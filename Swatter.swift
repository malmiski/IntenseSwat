//
//  Swatter.swift
//  IntenseSwat
//
//  Created by Mastermind on 1/7/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation


class Swatter:CCNode{
    
    //     This code deals with the swatter and its methods,
    //     might place this in swatters own class perhaps
    var swatter:CCNode?=nil
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
        let point = touch.locationInNode(self)
        //        Safety check to guard against tapping on the screen in the middle of the swatter animation
        if(self.parent != nil){
            swatter!.removeFromParent()
        }
        //      Don't want to load the swatter more than once
        if(swatter==nil){
            swatter = CCBReader.load("Swatter", owner:self)
        }else{
            //      Reset the animation
            let manager:CCAnimationManager = swatter!.animationManager!
            manager.runAnimationsForSequenceNamed("SwatterTimeline")
        }
        
        swatter!.position = point
        addChild(swatter)
        //addChild(FlyingFly.generateFly(2, bezierPath: nil, origin: point))
    }
    func swatBegins(){
        //TODO: Implement a method for determining if a fly or if multiple flies are underneath the swatter, thereby eliminating them
        //eliminateFlies()
    }
    func swatEnds(){
        swatter!.removeFromParent()
    }


}