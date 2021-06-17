//
//  NetworkHelper.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 05.06.2021.
//

import Foundation
import UIKit

class NetworkHelper{
    
    let pageCash:NSCache<NSString,NSData> = {
        
        let cash = NSCache<NSString,NSData>()
        //Настройки кэша
        //
        return cash
    }()
    
    var users = [UserModel]()
    
    var pageURL:URL? // url
    let ghPath = "https://api.github.com/users/" // Путь до API
    
    static let shared = NetworkHelper() // singleton
    private init() {}
    
    
    func getUsers(withProfileName name:String) -> [UserModel]{
        
        if let object = pageCash.object(forKey: name as NSString){//Если в кэше пользователь есть
            
            JSONHelper.shared.dataToModel(data: object as Data)

        }
        else{//Если в кэше пользователя нет
            
            pageURL = URL(string: ghPath + name)
            
            URLSession.shared.dataTask(with: pageURL!) { [weak self] data, response, error in // ! Ставить нельзя!
                
                guard let strongSelf = self else {return}

                
                if let error = error{//Проверка на наличие ошибки
                    
                    debugPrint(error.localizedDescription) //Вывод ошибки если такая есть
                }
                else{
                    
                    if strongSelf.pageCash.object(forKey: name as NSString) == nil{ //Добавление пользователя в кэш
                        
                        strongSelf.pageCash.setObject(data! as NSData, forKey: name as NSString)
                    }
                    
                    JSONHelper.shared.dataToModel(data: data!)
                }
            }.resume()
            
            
        }
        
        return users
    }
}

