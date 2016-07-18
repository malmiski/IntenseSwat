//
//  HighscoreLayer.swift
//  IntenseSwat
//
//  Created by Basement on 1/27/16.
//  Copyright © 2016 Apportable. All rights reserved.
//
import CoreData

@available(iOS 8.0, *)
class HighscoreLayer:CCNodeColor{
    weak var score_one:CCLabelTTF?
    weak var score_two:CCLabelTTF?
    weak var score_three:CCLabelTTF?
    
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
        let fetchedObjects:[Highscores] = CoreDataController.instance.getHighscores()
        var scoreLabels:[CCLabelTTF?] = [score_one, score_two, score_three]
        for i in (0..<3){
            if(fetchedObjects.count > i){
            scoreLabels[i]!.string = "\(fetchedObjects[i].score!.integerValue)"
            }
        }
    }
    
}