//
//  SceneManager.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class SceneManager{
    static var instance = SceneManager()
    
    func showScene(name:String, selectorToPerform:Selector?=nil){
        let scene = CCBReader.loadAsScene(name)
        if (selectorToPerform != nil){
        scene.performSelector(selectorToPerform!)
        }
        CCDirector.sharedDirector().presentScene(scene)
    }
}