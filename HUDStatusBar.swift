//
//  HUDStatusBar.swift
//  IntenseSwat
//
//  Created by Basement on 12/23/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation
class HUDStatusBar:CCNode{
    weak var timeLabel:CCLabelTTF?
    weak var fliesLabel:CCLabelTTF?
    weak var scoreLabel:CCLabelTTF?
    
    // Whenever we set these variables, we update the label that is associated with it
    var time:CCTime = 0{
        didSet{
            timeLabel!.string = "Time: \(String(format:"%.1f",time))s"
        }
    }
    var flies:Int = 0{
        didSet{
            fliesLabel!.string = "Flies: \(flies)"
        }
    }
    var score:Int = 0{
        didSet{
            scoreLabel!.string = "Score: \(score)"
        }
    }
    
    let size = CCDirector.sharedDirector().viewSize()
    func didLoadFromCCB(){
        timeLabel!.position = CGPoint(x:3,y:size.height)
        fliesLabel!.position = CGPoint(x:0.4*size.width,y:size.height)
        scoreLabel!.position = CGPoint(x:0.7*size.width,y:size.height)
        time = 0
        flies = 0
        score = 0
    }
}