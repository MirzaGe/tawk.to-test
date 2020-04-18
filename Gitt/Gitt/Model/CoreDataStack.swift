//
//  CoreDataStack.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/18/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import CoreData

/**
 The singleton that handles the Core Data stack.
 */
class CoreDataStack {
    
    // MARK: - Properties
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Gitt")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()

    // MARK: Init
    
    private init() {}
    
    // MARK: - Functions

    func saveContext () {
        print("SAVE CONTEXT")
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - More Helpers
    
    /// Fetch the specific locally stored user.
    func getUser(_ userId: Int) -> User? {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let userid = "\(userId)"
        let predicate = NSPredicate(format: "id == \(userid)")
        fetchRequest.predicate = predicate
        
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.first
        } catch let error {
            print(error)
            return nil
        }
    }
    
    /// Fetch the separated entity note for the specific user.
    func getNoteForUser(_ user: User) -> Note? {
        let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        let userid = "\(Int(user.id))"
        let predicate = NSPredicate(format: "userId == \(userid)")
        fetchRequest.predicate = predicate
        
        do {
            let notes = try managedObjectContext.fetch(fetchRequest)
            return notes.first
        } catch let error {
            print(error)
            return nil
        }
    }
}
