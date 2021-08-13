//
//  CoreDataHelper.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 23.05.2021.
//

import UIKit
import CoreData

class UsersCDHelper{
    
    //Создание контекста для работы с CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //singleton
    static let shared = UsersCDHelper()
    private init() {}
    
    //Сохранение Данных в БД
    private func save(){
        do {
            try self.context.save()
        }
        catch  {fatalError("Can not to save in CoreData!")}
    }
    
    //Добавление записи в CoreData
    func add() {
        
        save()
    }
    
    //Удаление записи из CoreData
    func delete(){
        
    }
    
    //Обновление записей в CoreData
    func refresh() {
        
    }
    
    
    //TODO: Добавить запрос к БД с условиями(для поиска)
    //Получение записей из CoreData
    func get(withName:String?) -> [Users] {

        do {
            let tempData:[Users] = try context.fetch(Users.fetchRequest())
            return tempData
        }
        catch {
            return []
        }
    }
}

