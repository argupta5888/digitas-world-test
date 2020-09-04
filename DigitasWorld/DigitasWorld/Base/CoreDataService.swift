//
//  CoreDataService.swift
//  DigitasWorld
//
//  Created by ashok on 04/09/20.
//  Copyright © 2020 eSoft Technologies. All rights reserved.
//

import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: "DigitasWorld", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    private lazy var peristentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let applicationDocumentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let persistentStoreUrl: URL = applicationDocumentsDirectory.appendingPathComponent("DigitasWorld.sqlite")
        
        print("LOCAL DB URL: \(persistentStoreUrl)")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreUrl, options: nil)
        }
        catch {
            fatalError("Persistent store error! \(error)")
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let managedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.peristentStoreCoordinator
        
        return managedObjectContext
    }()
    
    func saveContext() throws {
        if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            }
            catch {
                throw CustomError.DatabaseError
//                fatalError("There was an error saving the managed object context \(error)")
            }
        }
    }
}
