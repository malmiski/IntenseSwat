//
//  HighscoreScene.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class HighscoreScene: CCNode{
    weak var backButton:CCNode?
    func didLoadFromCCB(){
     // TODO: Enter code to pull from database highscores and populate them into
     // a collection
        /*self.horizontalScrollEnabled = false
        self.verticalScrollEnabled = true
        self.bounces = true
        self.contentSize = CCDirector.sharedDirector().viewSize()
        */
        let highscores = [["date": NSDate.distantPast(), "score":100], ["date": NSDate.distantPast(), "score":250], ["date": NSDate.distantPast(), "score":132]]
        populateScores(highscores);
        let a = backButton!
        a.position = CGPointZero
        backButton!.removeFromParent()
        SceneManager.instance.hud.addChild(a)
        let scrollNode:CCScrollView = self.parent! as! CCScrollView
        scrollNode.contentNode = self
        scrollNode.contentSizeType = CCSizeType(widthUnit: .Points, heightUnit: .Points)
        self.contentSize = CGSize(width: CCDirector.sharedDirector().viewSize().width, height: 1440)//CGFloat(16*highscores.count*30))
        self.position = CGPoint(x:0,y:0)
        
        
        print(self.contentSize)
    }
    func populateScores(scores:[[String:NSObject]]){
        let dateFormat = NSDateFormatter();
        dateFormat.dateFormat = "M-dd"
        //self.contentSize = CGSize(width:self.contentSize.width, height:CGFloat(scores.count*30*16))
        for(var i = 0; i<scores.count*30; i++){
            let j = i;
            i=i%scores.count;
//            print(scores[i])
            let score = scores[i]["score"] as! Int
            let date = scores[i]["date"] as! NSDate
            let node = CCBReader.load("HighscoreTemplate") as! HighscoreTemplate
            node.colorNode!.contentSizeInPoints = CGSize(width:CCDirector.sharedDirector().viewSize().width, height:14)
            node.position = CGPoint(x:0,y:CGFloat(j*16))
            print(node.position)
            node.dateLabel!.string = dateFormat.stringFromDate(date)
            node.scoreLabel!.string = "\(score)"
            node.zOrder = -999;
            addChild(node)
            i = j;
        }
    }
    func back(){
    SceneManager.instance.showScene("MainScene")
    }
}