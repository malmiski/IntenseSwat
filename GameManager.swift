//
//  GameManager.swift
//  IntenseSwat
//
//  Created by Basement on 12/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class GameManager
{
    static let sharedInstance = GameManager()
    

    // Optional variable to point to the current scene being shown
    var currentScene:CCScene? = nil
    
    private init()
    {
        
    }
    
    // returns current scene which can be cast
    func getCurrentScene() -> CCScene?
    {
        // BOSS: Do we want this function to be generic similar to the one in SceneManager?
        return currentScene
    }
    
    func setCurrentScene(currentScene : CCScene?)
    {
        self.currentScene = currentScene;
    }
    

}