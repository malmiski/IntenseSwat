//
//  PauseLayer.swift
//  IntenseSwat
//
//  Created by Basement on 1/28/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

class PauseLayer:CCNodeColor{
    override init(color:CCColor!=CCColor.redColor()){
        super.init(color:color, width:0, height:0)
        let layer = CCBReader.load("PauseLayer", owner:self)
        let colorNode = layer.children.first! as! CCNodeColor
        layer.removeAllChildren()
        self.addChild(colorNode)
        
        GameManager.sharedInstance.currentScene!.pauseGame()
    }
    
    func sfx_selected(){
        
    }
    
    func bg_selected(){
    
    }
    
    func reset_selected(){
    
    }
    func return_selected(){
        SceneManager.instance.hideLayer()
        GameManager.sharedInstance.currentScene!.unpauseGame()
    }
    
    func exit_selected(){
        SceneManager.instance.showMainScene()
    }

}