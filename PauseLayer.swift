//
//  PauseLayer.swift
//  IntenseSwat
//
//  Created by Basement on 1/28/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

@available(iOS 8.0, *)
class PauseLayer:CCNodeColor{
    override init(color:CCColor!=CCColor.redColor()){
        super.init(color:color, width:0, height:0)
        let layer = CCBReader.load("PauseLayer", owner:self)
        let colorNode = layer.children.first! as! CCNodeColor
        layer.removeAllChildren()
        self.addChild(colorNode)
        
        GameManager.sharedInstance.currentScene!.pauseGame()
    }
    
    
    func reset_selected(){
        //GameManager.sharedInstance.currentScene!.unpauseGame()
        //AudioManager.instance.stopEverything()
        SceneManager.instance.showGameSceneContinuous()
    }
    func return_selected(){
        SceneManager.instance.hideLayer()
        GameManager.sharedInstance.currentScene!.unpauseGame()
    }
    
    func exit_selected(){
        //AudioManager.instance.stopEverything()
        SceneManager.instance.showMainScene()
    }

}
