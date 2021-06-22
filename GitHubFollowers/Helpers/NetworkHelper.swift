//
//  NetworkHelper.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 05.06.2021.
//

import Foundation
import UIKit

class NetworkHelper{
    
    let userCash:NSCache<NSString,NSData> = {
        
        let cash = NSCache<NSString,NSData>()
        //Настройки кэша(добавить)
        //
        return cash
    }()
    
    let avatarCash:NSCache<NSString,UIImage> = {
        
        let cash = NSCache<NSString,UIImage>()
        //Настройки кэша(добавить)
        //
        return cash
    }()
    
    var users = [UserModel]()
    
    let ghPath = "https://api.github.com/users/" // Путь до API
    
    static let shared = NetworkHelper() // singleton
    private init() {}
    
    
    func getUser(withProfileName name:String, completionHandler: @escaping (Result<UserModel, NetworkError>) -> () ){
        
        var result:UserModel?
        
        if let object = userCash.object(forKey: name as NSString){//Если в кэше пользователь есть
            
            do {
                result  = try JSONDecoder().decode(UserModel.self, from: object as Data)
                
                getImage(fromUrlString: result!.avatarUrl) { avatarImage in
                    
                    result?.avatarImage = avatarImage
                }
                
                
                getFollowers(fromUrlString: result!.followersUrl){ res in
                    
                    result?.followersModel = res
                }
                
                completionHandler(Result.success(result!))
            } catch {
                completionHandler(Result.failure(.failure))
            }
        }
        else{//Если в кэше пользователя нет
            
            
            guard let userURL = URL(string: ghPath + name) else{
                completionHandler(Result.failure(.failure))
                return
            }
            
            URLSession.shared.dataTask(with: userURL) { [weak self] data, response, error in
                
                guard let strongSelf = self else {return}
                
                if let _ = error { //Проверка на наличие ошибки
                    completionHandler(Result.failure(.failure))
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { //Проверка на правильный код
                    completionHandler(Result.failure(.badResponse))
                    return
                }
                
                do {
                    result  = try JSONDecoder().decode(UserModel.self, from: data!)
                    
                    
                    strongSelf.getImage(fromUrlString: result!.avatarUrl) { avatarImage in
                        
                        result?.avatarImage = avatarImage
                    }
                    
                    strongSelf.getFollowers(fromUrlString: result!.followersUrl){ res in
                        
                        result?.followersModel = res
                        completionHandler(Result.success(result!))
                    }
                    
                    if strongSelf.userCash.object(forKey: name as NSString) == nil{ //Добавление пользователя в кэш если норм декодировалось
                        
                        strongSelf.userCash.setObject(data! as NSData, forKey: name as NSString)
                    }
                }
                catch {
                    completionHandler(Result.failure(.failure))
                }
            }.resume()
        }
    }
    
    private func getFollowers(fromUrlString:String, handler: @escaping ([FollowerModel]) -> () ){
        
        var result = [FollowerModel]()
        
        guard let followerURL = URL(string: fromUrlString) else{
            handler([])
            return
        }
        
        URLSession.shared.dataTask(with: followerURL) { data, response, error in
            
            if let _ = error { //Проверка на наличие ошибки
                handler(result)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { //Проверка на правильный код
                handler(result)
                return
            }
            
            do {
                result = try JSONDecoder().decode([FollowerModel].self, from: data!)
                
                handler(result)
            }
            catch {
                handler(result)
            }
            
        }.resume()
    }
    
    
    func getImage(fromUrlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = URL(string: fromUrlString) else {
            completionHandler(nil)
            return
        }
        
        if let avatarImageFromCash = avatarCash.object(forKey: fromUrlString as NSString){
            
            completionHandler(avatarImageFromCash)
        }
        else{
            
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                
                guard let strongSelf = self else{return}
                
                guard let wrapedData = data else{return}
                
                if let image = UIImage(data: wrapedData){
                    
                    strongSelf.avatarCash.setObject(image, forKey: fromUrlString as NSString)
                    completionHandler(image)
                }
                else{
                    completionHandler(nil)
                }
            }.resume()
        }
    }
}

