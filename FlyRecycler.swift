//
//  FlyRecycler.swift
//  IntenseSwat
//
//  Created by Mohanad Almiski on 1/14/17.
//  Copyright © 2017 Apportable. All rights reserved.
//

import Foundation

@available(iOS 8.0, *)
class FlyRecycler{
    static let sharedInstance = FlyRecycler()
    
    //var fliesInAction:[FlyingFly] = []
    //var fliesUsed:[FlyingFly] = []
    var fliesInAction = NSHashTable()
    var fliesUsed = NSHashTable()
    private init(){
        
    }
    
    
    func getFly(time:CCTime?=nil, bezierPath:ccBezierConfig?=nil, origin:CGPoint?=nil) -> FlyingFly{
        let fly:FlyingFly
        if(fliesUsed.count == 0){
            fly = FlyingFly.generateFly(time, bezierPath: bezierPath, origin: origin)
        }else{
            fly = fliesUsed.allObjects.first! as! FlyingFly
            fliesUsed.removeObject(fly)
            let randomPath:CCAction = FlyingFly.generateRandomPath(fly, time: time, bezierPath: bezierPath, origin: origin)
            fly.runAction(randomPath)
            fly.paused = false
            fly.continueBuzzing()
            fly.animationManager.runAnimationsForSequenceNamed("FlyingFlyTimeline")
        }
        fliesInAction.addObject(fly)
        print(String(format:"Number of flies total: %d + %d = %d", fliesInAction.count, fliesUsed.count, fliesInAction.count + fliesUsed.count))
        return fly
    }
    
    func recycleFly(fly:FlyingFly){
        fly.stopAllActions()
        fliesInAction.removeObject(fly)
        fliesUsed.addObject(fly)
        print(String(format:"Recycling: Number of flies total: %d + %d = %d", fliesInAction.count, fliesUsed.count, fliesInAction.count + fliesUsed.count))
    }
    func restart(){
        fliesInAction.removeAllObjects()
        fliesUsed.removeAllObjects()
    }
}
