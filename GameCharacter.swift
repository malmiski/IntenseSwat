//
//  GameCharacter.swift
//  IntenseSwat
//
//  Created by Mastermind on 11/28/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class GameCharacter: GameObject
{
    var isAlive :Bool;
    var health: Int;
    var level: Int;
    
    init(location : Double, health : Int){
        self.level = 1;
        self.isAlive = true;
        self.health = health;
        super.init(location:location);
    }
    
    func DestroyGameCharacter(){
        
        // destroy game character
        isAlive = false;
        super.Destroy();
    }
    
    func DecreaseHealth(amount: Int){
        
        // decrease health
        if(self.health > 0){
            self.health -= amount;
        }
        
        if(self.health <= 0){
            DestroyGameCharacter();
        }
    }
    
    func IncreaseHealth(amount: Int){
        // increase health
        self.health += amount;
    }
    
    func LevelUp(){
        self.level++;
    }
    
    func LevelDown(){
        self.level--;
    }
}