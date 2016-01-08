//
//  GameScene.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class GameScene: CCNode{
    weak var backgroundNode:CCNode?
    let size = CCDirector.sharedDirector().viewSizeInPixels()
    let sizeInPoints = CCDirector.sharedDirector().viewSize()
    let hudStatusBar = CCBReader.load("HUDStatusBar") as! HUDStatusBar
    var flies:[FlyingFly] = []
    var countTime = false
    
    // how many lives the player has
    var currentLives = 5;
    
    // Four Corners of the Swatter head
    weak var node_1, node_2, node_3, node_4 : CCNode?
    
    func didLoadFromCCB(){
        /*
        Code to create repeatable background
        */
        let sprite:CCSprite = CCSprite(imageNamed: "KitchenTile.png");
        let texture = sprite.texture!
        var params = ccTexParams(minFilter: UInt32(GL_LINEAR), magFilter: UInt32(GL_LINEAR), wrapS: UInt32(GL_REPEAT), wrapT: UInt32(GL_REPEAT))
        texture.setTexParameters(&params)
        sprite.setTextureRect(CGRect(origin: CGPoint(x: 0,y: 0), size: size));
        backgroundNode!.addChild(sprite)
        
    }
    
    func back(){
//      Code to return to the main menu
        endGame();
        SceneManager.instance.showMainScene()
    }
    
    func cleanup(){
    
    }
    
    func endGame(){
//      This will set off a series of events that will lead to the end of the game, and the saving of scores
        SceneManager.instance.showMainScene()
    }
    
//     This code deals with the swatter and its methods, 
//     might place this in swatters own class perhaps
    var swatter:CCNode?=nil
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
        let point = touch.locationInNode(self)
//        Safety check to guard against tapping on the screen in the middle of the swatter animation
        if(swatter?.parent != nil){
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
        eliminateFlies()
    }
    func swatEnds(){
        swatter!.removeFromParent()
    }
    
    func eliminateFlies(){
        flies = flies.filter({
            if($0.parent==nil){
                return false
            }
            if(withinSwatter($0.position)){
                $0.killSelf(self)
                hudStatusBar.flies++
                
                // BOSS: right here is where the fly is killed without the Swatter?
                decreaseLife();
                return false
            }
            return true
        })
    }
    func withinSwatter(var position:CGPoint)->Bool{
        position.x = position.x - swatter!.position.x
        position.y = position.y - swatter!.position.y

        if(position.x <= node_4!.position.x && position.x >= node_1!.position.x){
            if(position.y<=node_2!.position.y && position.y>=node_3!.position.y){
            return true
            }
        }
        
        return false
    }
    /*
    func pointInQuad(point:CGPoint, v1:CGPoint,v2:CGPoint,v3:CGPoint,v4:CGPoint)->Bool{
        let line1 = line(v1, v2)
        return true
        return false
    }
    func line(v1:CGPoint, v2:CGPoint)->[CGFloat]{
        let slope = (v1.y - v2.y)/(v1.x-v2.x)
        let yInt =
    }*/
    
    var startTimer:CCNode?=nil
    // This is called when the continuous option is selected
    func startContinuous(){
        // Until the start timer finishes, then we won't allow touches to be registered on the main node
        SceneManager.instance.disableTouchForNode(self)
        let label = CCLabelTTF(string: "Continuous Mode", fontName:  "AmericanTypewriter", fontSize: 26);
        label.anchorPoint = CGPoint(x:0,y:1)
        label.positionInPoints = CGPoint(x:0,y:sizeInPoints.height)
        //SceneManager.instance.hud.addChild(label)
        
        startTimer = CCBReader.load("CountDown", owner: self)
        startTimer!.position = CGPoint(x: 0.5 * sizeInPoints.width,y: 0.5 * sizeInPoints.height)
        
        // This starts the sequence of events that leads to the game beginning
        SceneManager.instance.hud.addChild(startTimer)
        hudStatusBar.position = CGPoint(x:0, y:0)
        SceneManager.instance.hud.addChild(hudStatusBar)
        let hudBottomBar:HUDBottomBar = CCBReader.load("HUDBottomBar", owner: self) as! HUDBottomBar
        SceneManager.instance.hud.addChild(hudBottomBar)
    }
    
    
    
    // This variable will be for the continuous level, it determines the rate of release for the flies
    var rateOfRelease = 1
    // As set up in SpriteBuilder, this callback will be called when the count down text dissapears
    func countDownFinished(){
        startTimer!.removeFromParent()
        SceneManager.instance.enableTouchForNode(self)
        //TODO: Begin to populate the screen with flies, increment the time every second, and calculate the score
        countTime = true
        performSelector("incrementTime",withObject: self,afterDelay: 0.1)
        continuousFlyGeneration()
    }
    func continuousFlyGeneration(){
        if(countTime){
            genFly()
            performSelector("continuousFlyGeneration", withObject:self, afterDelay:CCTime(FlyingFly.randomFloat()*2))
        }
    }
    
    func incrementTime(){
        if(countTime){
            self.hudStatusBar.time += 0.1
            performSelector("incrementTime",withObject: self,afterDelay: 0.1)
        }
    }
    
    // This is called when levels are requested
    func startWin(){
        let label = CCLabelTTF(string: "Win Mode", fontName:  "AmericanTypewriter", fontSize: 26);
        label.anchorPoint = CGPoint(x:0,y:1)
        label.positionInPoints = CGPoint(x:0,y:sizeInPoints.height)
        addChild(label)
    }
    func genFly(){
        print("creating fly")
        let fly = FlyingFly.generateFly(2)
        flies.append(fly)
        addChild(fly)
    }
    
    func decreaseLife(){
        print("creating fly")
        if(currentLives > 0){
            currentLives = currentLives - 1;
        }else{
            endGame();
        }
    }
}