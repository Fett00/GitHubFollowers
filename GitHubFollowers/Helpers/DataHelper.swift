//
//  CoreDataHelper.swift
//  GitHubFollowers
//
//  Created by Садык Мусаев on 23.05.2021.
//

import UIKit
import CoreData

class CoreDataHelper{
    
    //Создание контекста для работы с CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //Куда записывать(Entity)
    let managedObject:NSManagedObject
    
    init(withManagedObject:NSManagedObject) {
        managedObject = withManagedObject
    }
    
    //Сохранение Данных в БД
    private func save(){
        do {
            try self.context.save()
        }
        catch  {fatalError("Can not to save in CoreData!")}
    }
    
    //Добавление записи в CoreData
    func add(object:NSManagedObject) {
        
    }
    
    //Удаление записи из CoreData
    func delete(){
        
    }
    
    //Обновление записей в CoreData
    func refresh() {
        
    }
    
    
    //TODO: Добавить запрос к БД с условиями
    //Получение записей из CoreData
    func get(object:NSManagedObject) -> [NSManagedObject] {
        
        var result:[NSManagedObject] = [NSManagedObject()]
        
        return result
    }
}

class CurrentUserHelper{
    
    static func getCurrentUser(){
        
    }
}
