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
    
    func save(){
        do{
            try self.managedObjectContext.save()
        }catch{
        fatalError("Couldn't save")
        }
    }
    
    func getHighscores() -> [Highscores]{
        let query:NSFetchRequest = NSFetchRequest()
        query.entity = NSEntityDescription.entityForName("Highscores", inManagedObjectContext: managedObjectContext)
        query.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        query.fetchLimit = 3
        let fetchedObjects:[Highscores]
        do{
            fetchedObjects = try CoreDataController.instance.managedObjectContext.executeFetchRequest(query) as! [Highscores]
        }catch _{
            fatalError("Something happened")
        }
        print("Ello, ello, printing some highscores for ya \(fetchedObjects)")
        return fetchedObjects
    }
    
    func saveHighscore(score:Int, time:Double, flies:Int){
        let managedHighscore:NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Highscores", inManagedObjectContext: managedObjectContext)
        managedHighscore.setValue(score, forKey: "score")
        managedHighscore.setValue(time, forKey: "time")
        managedHighscore.setValue(flies, forKey: "flies")
        save()
    }

}