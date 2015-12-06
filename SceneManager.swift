//
//  SceneManager.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class SceneManager{
    static var instance = SceneManager()

    
    func showScene<T where T:CCNode>(name:String, selectorToPerform:Selector?=nil)->T{
        let scene:CCScene = CCBReader.loadAsScene(name)
        var gameNode:T = T()
        if (selectorToPerform != nil){
            gameNode =         scene.children[0] as! T
//scene.getChildByName("mainNode", recursively: false) as! T
            gameNode.performSelector(selectorToPerform!)
        }
        CCDirector.sharedDirector().presentScene(scene)
        return gameNode
    }
    
    func showGameSceneContinuous(){
        let scene:GameScene = showScene("GameScene", selectorToPerform: "startContinuous")
    }
    func showGameSceneWin(){
        let scene:GameScene = showScene("GameScene", selectorToPerform: "startContinuous")
    }
    func showCameraScene(){
        let scene:CameraScene = showScene("CameraScene")
    }
    func showMainScene(){
        let scene:MainScene = showScene("MainScene")
    }
    
}