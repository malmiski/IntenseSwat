//
//  GameObject.swift
//  IntenseSwat
//
//  Created by Mastermind on 11/28/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class GameObject{
    
    var location: Double;
    
    
    init(location: Double)
    {
        self.location = location;
    }
    
    func SetLocation(location :Double)
    {
        self.location = location;
    }
    
    func GetLocation()-> Double{
        return self.location;
    }
    
    func Destroy(){
        // Destroy Game Object
    }
    
}
