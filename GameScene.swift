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
        SceneManager.instance.showScene("MainScene")
    }
    func toggleLayer(){
        let node = CCBReader.load("GameMenu") as! GameMenu
        
            SceneManager.instance.showLayer(node)
    }

    func endGame(){
    
    }
    
    // This is called when the continuous option is selected
    func startContinuous(){
        let label = CCLabelTTF(string: "Continuous Mode", fontName:  "AmericanTypewriter", fontSize: 26);
        label.anchorPoint = CGPoint(x:0,y:1)
        label.positionInPoints = CGPoint(x:0,y:sizeInPoints.height)
        addChild(label)
    }
    // This is called when levels are requested
    func startWin(){
        let label = CCLabelTTF(string: "Win Mode", fontName:  "AmericanTypewriter", fontSize: 26);
        label.anchorPoint = CGPoint(x:0,y:1)
        label.positionInPoints = CGPoint(x:0,y:sizeInPoints.height)
        addChild(label)
    }
    func generateFly() -> FlyingFly{
        return CCBReader.load("FlyingFly") as! FlyingFly
    }
}