//
//  CoreDataHelper.swift
//  DigitasWorld
//
//  Created by ashok on 04/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import CoreData


class CoreDataHelper {
    
    static func saveRecord(entity: NSManagedObject.Type, list:[Country]) throws {
        
        let service = CoreDataService.shared
        let context = service.managedObjectContext
        
        
        for item in list {
            let coreObject = NSEntityDescription.insertNewObject(forEntityName: String(describing:"Country_MO"), into: context)
            item.modelToCoreData(coreData: coreObject)
            do {
                try service.saveContext()
            }
            catch(let error) {
                throw error
            }
        }
    }
    
    static func selectAllFrom<T: NSManagedObject>(entity: String) throws ->[T] {
        
        let service = CoreDataService.shared
        var list: [T] = []
        let request =  NSFetchRequest<T>(entityName: String(describing: entity))
        
        do {
            list = try service.managedObjectContext.fetch(request)
            return list
        }
        catch {
            throw CustomError.DatabaseError
        }
    }
    
    static func deleteAllFrom(entityName: String) throws -> Bool {
        
        var list: [NSManagedObject] = []
        let service = CoreDataService.shared
        let request =  NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            list = try service.managedObjectContext.fetch(request)
            for row in list {
                service.managedObjectContext.delete(row)
            }
            do {
                try service.managedObjectContext.save()
                return true
            }
            catch {
                throw CustomError.DatabaseError
            }
        }
        catch {
            throw CustomError.DatabaseError
        }
    }
}
