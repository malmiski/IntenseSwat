//
//  CoreDataController.swift
//  IntenseSwat
//
//  Created by Basement on 12/18/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import CoreData
import UIKit
class CoreDataController{
    var managedObjectContext:NSManagedObjectContext
    static let instance = CoreDataController()
    // Method ripped directly off of Apples guide on Core Data
    private init(){
        guard let modelURL = NSBundle.mainBundle().URLForResource("Scores", withExtension: "momd") else {
            fatalError("error loading the model data")
        }
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else{
            fatalError("error loading the mom")
        }
    
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[0]
            /* The directory the application uses to store the Core Data store file.
            This code uses a file named "DataModel.sqlite" in the application's documents directory.
            */
            let storeURL = docURL.URLByAppendingPathComponent("Scores.sqlite")
            do {
                try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }

    }

    func loadUserImage() -> UserImage{
        let request = NSFetchRequest(entityName: "UserImage")
        var results:[UserImage]
        
        do{
            results = try self.managedObjectContext.executeFetchRequest(request) as! [UserImage]
            if(results.isEmpty){
                let newUserImage = NSEntityDescription.insertNewObjectForEntityForName("UserImage", inManagedObjectContext: self.managedObjectContext) as! UserImage

                results = try self.managedObjectContext.executeFetchRequest(request) as! [UserImage]
            }
            
        }catch{
        fatalError("couldn't load the picture data")
        }
        return results.first!
    }
    
    func save(){
        do{
            try self.managedObjectContext.save()
        }catch{
        fatalError("couldn't save")
        }
    }

}