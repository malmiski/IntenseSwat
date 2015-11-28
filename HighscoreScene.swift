//
//  HighscoreScene.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class HighscoreScene: CCNode{
    func didLoadFromCCB(){
     // TODO: Enter code to pull from database highscores and populate them into
     // a collection
        /*self.horizontalScrollEnabled = false
        self.verticalScrollEnabled = true
        self.bounces = true
        self.contentSize = CCDirector.sharedDirector().viewSize()
        */let highscores = [["date": NSDate.distantPast(), "score":100], ["date": NSDate.distantPast(), "score":250], ["date": NSDate.distantPast(), "score":132]]
        populateScores(highscores);
        
    }
    func populateScores(scores:[[String:NSObject]]){
        let dateFormat = NSDateFormatter();
        dateFormat.dateFormat = "M-dd"
        //self.contentSize = CGSize(width:self.contentSize.width, height:CGFloat(scores.count*30*16))
        for(var i = 0; i<scores.count*30; i++){
            var j = i;
            i=i%scores.count;
            print(scores[i])
            let score = scores[i]["score"] as! Int
            let date = scores[i]["date"] as! NSDate
            let node = CCBReader.load("HighscoreTemplate") as! HighscoreTemplate
            node.colorNode!
                .contentSizeInPoints = CGSize(width:CCDirector.sharedDirector().viewSize().width, height:14)
            //node.anchorPoint = CGPoint(x:0,y:1)
            node.position = CGPoint(x:0,y:CCDirector.sharedDirector().viewSize().height-CGFloat((j+1)*16))
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