//
//  GameManager.swift
//  IntenseSwat
//
//  Created by Basement on 12/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

@available(iOS 8.0, *)
class GameManager
{
    static let sharedInstance = GameManager()
    

    

    // Optional variable to point to the current scene being shown
    var currentScene:GameScene? = nil
    
    private init()
    {
        
    }
    

    
    // returns current scene which can be cast
    func getCurrentScene() -> GameScene?
    {
        // BOSS: Do we want this function to be generic similar to the one in SceneManager?
        return currentScene
    }
    
    func setCurrentScene(currentScene : GameScene?)
    {
        self.currentScene = currentScene;
    }
    
    // BOSS: it can't be this simple can it?
    func Pause()
    {
        currentScene?.paused = true;
    }
    
    func Resume()
    {
        currentScene?.paused = false;
    }
    

}