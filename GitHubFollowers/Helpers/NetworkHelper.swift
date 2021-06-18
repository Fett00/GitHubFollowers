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
                
                guard let data = data else{ //Проверка на наличие приходящих данных
                    completionHandler(Result.failure(.failure))
                    return
                }
                
                do {
                    result  = try JSONDecoder().decode(UserModel.self, from: data)
                    
                    if strongSelf.userCash.object(forKey: name as NSString) == nil{ //Добавление пользователя в кэш если норм декодировалось
                        
                        strongSelf.userCash.setObject(data as NSData, forKey: name as NSString)
                    }
                    
                    completionHandler(Result.success(result!))
                }
                catch {
                    completionHandler(Result.failure(.failure))
                }
            }.resume()
        }
    }
    
    func getImage(fromURL:URL){//Добавить кэширование
        
    }
}

