//
//  GameFinishLayer.swift
//  IntenseSwat
//
//  Created by Basement on 1/28/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

class GameFinishLayer:CCNodeColor{
    weak var flies_value:CCLabelTTF?
    weak var time_value:CCLabelTTF?
    weak var variable_text:CCLabelTTF?
    weak var score_value:CCLabelTTF?
    
    override init(color:CCColor!=CCColor.redColor()){
        super.init(color:color, width:0, height:0)
        let layer = CCBReader.load("GameFinishLayer", owner:self)
        let colorNode = layer.children.first! as! CCNodeColor
        updateScores(1,timeValue:1, scoreValue:1)
        layer.removeAllChildren()
        self.addChild(colorNode)
    }
    
    func try_again_selected(){
        SceneManager.instance.showGameSceneContinuous()
    }
    
    func quit_selected(){
        SceneManager.instance.showMainScene()
    }
    
    // Updates the scores for the current game played
    func updateScores(fliesValue:Int, timeValue:CCTime, scoreValue:Int){
        /*
        flies_value!.string = ""
        time_value!.string = ""
        score_value!.string = ""
        */
        flies_value!.string = "\(fliesValue)";
        time_value!.string = "\(timeValue)";
        score_value!.string = "\(scoreValue)";
    }
    
}