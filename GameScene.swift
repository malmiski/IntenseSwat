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
        endGame();
        SceneManager.instance.showMainScene()
    }
    
    func cleanup(){
    }
    func endGame(){
//        GameManager.instance.cleanup()
        SceneManager.instance.showMainScene()
    }
    // This code deals with the swatter and its methods, 
    // might place this in swatters own class perhaps
    var swatter:CCNode?=nil
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
        let point = touch.locationInNode(self)
        if(swatter?.parent != nil){
            swatter!.removeFromParent()
        }
        swatter = CCBReader.load("Swatter", owner: self)
        swatter!.position = point
        addChild(swatter)
        //addChild(FlyingFly.generateFly(2, bezierPath: nil, origin: point))
    }
    func swatBegins(){
        //swatEnds()
        //TODO: Implement a method for determining if a fly or if multiple flies are underneath the swatter, thereby eliminating them
    }
    func swatEnds(){
        swatter!.removeFromParent()
    }
    
    
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
        
    }
    
    // This is called when levels are requested
    func startWin(){
        let label = CCLabelTTF(string: "Win Mode", fontName:  "AmericanTypewriter", fontSize: 26);
        label.anchorPoint = CGPoint(x:0,y:1)
        label.positionInPoints = CGPoint(x:0,y:sizeInPoints.height)
        addChild(label)
    }
    func genFly(){
        print("hello")
        addChild(FlyingFly.generateFly())
    }
}