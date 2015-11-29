//
//  Enemy.swift
//  IntenseSwat
//
//  Created by Mastermind on 11/28/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class EnemyCharacter:GameCharacter
{
    
    var category: String;
    var isBoss: Bool;
    
    init(location: Double, health:Int, category: String, isBoss:Bool) {
        
        self.category = category;
        self.isBoss = isBoss;
        super.init(location: location, health: health);
    }
    
}