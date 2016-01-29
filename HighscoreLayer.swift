//
//  HighscoreLayer.swift
//  IntenseSwat
//
//  Created by Basement on 1/27/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

class HighscoreLayer:CCNodeColor{

    override init(color:CCColor!=CCColor.redColor()){
        super.init(color:color, width:0, height:0)
        let layer = CCBReader.load("HighscoreLayer", owner:self)
        let colorNode = layer.children.first! as! CCNodeColor
        updateScores()
        layer.removeAllChildren()
        self.addChild(colorNode)
    }
    func return_selected(){
        SceneManager.instance.hideLayer()
    }
    
    // Draws from CoreData and updates scores, not implemented yet
    func updateScores(){

    }
    
}