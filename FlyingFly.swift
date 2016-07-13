//
//  FlyingFly.swift
//  IntenseSwat
//
//  Created by Basement on 12/5/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class FlyingFly: CCNode{
    var alive = true
    
    static let sizeInPoints = CCDirector.sharedDirector().viewSize()
    func didLoadFromCCB(){
    }
    static func generateFly(time:CCTime?=nil,bezierPath:ccBezierConfig?=nil, origin:CGPoint?=nil) -> FlyingFly{
        let fly = CCBReader.load("FlyingFly") as! FlyingFly
        let randomPath:CCAction = generateRandomPath(fly, time: time, bezierPath: bezierPath, origin: origin)
        fly.runAction(randomPath)
        return fly
    }
    //
    static func randomFloat()->CGFloat{
        arc4random_stir()
        return CGFloat(Float(arc4random())/Float(UINT32_MAX))
    }
    // Here is the meat of the generation of the random fly
    static func generateRandomPath(fly:FlyingFly, time:CCTime?=nil, bezierPath:ccBezierConfig?=nil, origin:CGPoint?=nil)->CCAction{
        var time = time
        var bezierPath = bezierPath;
        arc4random_stir()
        if(origin==nil){
            fly.position = CGPoint(x:randomFloat() * sizeInPoints.width, y:randomFloat() * sizeInPoints.height)
        }else{
            fly.position = origin!
        }
        if(time==nil){
            time = CCTime(randomFloat()*2)
        }
        if(bezierPath==nil){
            arc4random_stir()
            let x = randomFloat() * sizeInPoints.width
            
            let y = randomFloat() * sizeInPoints.height
            bezierPath = ccBezierConfig(endPosition: CGPoint(x:x,y:y), controlPoint_1: CGPoint(x:fly.position.y, y:fly.position.y+10),controlPoint_2: CGPoint(x:x, y:y+10))
        }
        let pathAction = CCActionBezierTo(duration: time!, bezier: bezierPath!);
        let removeAction = CCActionCallBlock { () -> Void in
            // Since this fly got away decrease the players life
            GameManager.sharedInstance.currentScene!.decreaseLife()
            fly.removeFromParent()
        }
        let chainedAction = CCActionSequence(one:pathAction, two:removeAction)
        return chainedAction
    }
    
//  Here we stop any actions on the fly, replace it with a the
    func killSelf(caller:GameScene){
        alive = false
        stopAllActions()
        removeFromParent()
//      TODO: Add sprite for dead fly here:
//
        //caller.removeFly(self)
    }

}