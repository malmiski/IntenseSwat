//
//  Highscores+CoreDataProperties.swift
//  IntenseSwat
//
//  Created by Basement on 12/5/15.
//  Copyright © 2015 Apportable. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Highscores {

    @NSManaged var score: NSNumber?
    @NSManaged var time: NSNumber?
    @NSManaged var flies: NSNumber?

}
