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
    
    var users = [UserModel]()
    
    var userURL:URL? // url
    let ghPath = "https://api.github.com/users/" // Путь до API
    
    static let shared = NetworkHelper() // singleton
    private init() {}
    
    
    func getUser(withProfileName name:String, completionHandler: @escaping (Result<UserModel, NetworkError>) -> () ){
        
        var result:UserModel?
        
        if let object = userCash.object(forKey: name as NSString){//Если в кэше пользователь есть
            
            do {
                result  = try JSONDecoder().decode(UserModel.self, from: object as Data)
                completionHandler(Result.success(result!))
            } catch {
                completionHandler(Result.failure(.failure))
            }
        }
        else{//Если в кэше пользователя нет
            
            userURL = URL(string: ghPath + name)
            
            URLSession.shared.dataTask(with: userURL!) { [weak self] data, response, error in // userURL! Ставить нельзя!
                
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
                    
                    let followersModelURL = URL(string: result!.followersUrl)!
                    
                    strongSelf.getFollowers(fromURL: followersModelURL){ res in
                        
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
    
    private func getFollowers(fromURL:URL, handler: @escaping ([FollowerModel]) -> () ){
        
        var result = [FollowerModel]()
        
        URLSession.shared.dataTask(with: fromURL) { data, response, error in
            
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
    
    private func getImage(fromURL:URL){//Добавить кэширование //private???
        
    }
}

