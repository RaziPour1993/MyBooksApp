//
//  CoreDataManager.swift
//  MyBooksApp
//
//  Created by Mohammad Razipour on 2/4/20.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    private let modelName: String
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        // Initialize Managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        // Helpers
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        // URL Documents Directory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // URL Persistent Store
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        //        debugPrint(persistentStoreURL.absoluteString)
        
        do {
            // Add Persistent Store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
            
        } catch {
            fatalError("Unable to Add Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    deinit {
        print("deinit CoreDataManager")
    }
    
}
