//
//  SceneManager.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

@available(iOS 8.0, *)
class SceneManager{
    static var instance = SceneManager()
    // Optional variable to point to the current scene being shown
    var currentScene:CCScene? = nil
    // Optional variable to point to the current scene being shown
    var currentMainNode:CCNode? = nil
    // Optional variable to point to the current layer being shown
    var currentLayer:CCNode? = nil
    // These are CCActions that show and hide layers, they're constant
    let hideAction = CCActionMoveTo(duration: 1, position: CGPoint(x:CCDirector.sharedDirector().viewSize().width/2,y:CCDirector.sharedDirector().viewSize().height))
    let showAction = CCActionMoveTo(duration: 1, position: CGPoint(x:CCDirector.sharedDirector().viewSize().width/2, y:CCDirector.sharedDirector().viewSize().height/2))
    // This is the shadow background, just a filled black rectangle with an opacity of .6
    let shadowBackground = CCNodeColor(color: CCColor(red: 0, green: 0, blue: 0, alpha: 0.6))
    // The heads-up display, for displaying lots of things
    let hud:CCNode

    init(){
        hud = CCNode()
        hud.zOrder = 990
        hud.anchorPoint = CGPointZero
        hud.position = CGPointZero
        hud.name = "Heads Up Display"
    }
    // Code for the HUD
    func clearHUD(){
        hud.removeAllChildren()
    }
    func toggleHUDVisible(){
        hud.visible = !hud.visible
    }
    func hideHUD(){
        hud.visible = false
    }
    func showHUD(){
        hud.visible = true
    }
    
    // This method is generic to allow dynamic method calls to occur such
    // as calling startContinuous versus startWin
    func showScene<T where T:CCNode>(name:String, selectorToPerform:Selector?=nil)->T{
        hud.removeFromParent()
        clearHUD()
        showHUD()
        if(currentLayer != nil){
            currentLayer!.stopAllActions()
            currentLayer!.removeFromParent()
            currentLayer = nil
        }
        let scene:CCScene = CCBReader.loadAsScene(name)
//      We locate the top node of the scene, which we created in SpriteBuilder
//      and then we cast it to the generic type T, which allows us to perform
//      whatever method we want on a specific scene
        var gameNode:T = T()
        if (selectorToPerform != nil){
            gameNode = scene.children[0] as! T
            gameNode.performSelector(selectorToPerform!)
        }
        scene.addChild(hud)
        CCDirector.sharedDirector().presentScene(scene)
        
        currentScene = scene
        currentMainNode = gameNode
        return gameNode
    }
//  Convenience methods for showing various scenes
    func showGameSceneContinuous() -> GameScene{
        return showScene("GameScene", selectorToPerform: "startContinuous")
    }
    func showGameSceneWin() -> GameScene{
        return showScene("GameScene", selectorToPerform: "startWin")
    }

    func showMainScene() -> MainScene{
        AudioManager.instance.stopBackgroundMusic()
        return showScene("MainScene")
    }
    
    func showShadedBackground(){
        if(shadowBackground.parent == nil){
            shadowBackground.zOrder = 998
            currentScene?.addChild(shadowBackground)
        }
    }
    func hideShadedBackground(){
        if(shadowBackground.parent != nil){
            shadowBackground.removeFromParent()
        }
    }
    
    func showLayer(layer:CCNode, allowBackgroundTouches:Bool=false, darkenBackground:Bool=true) -> CCNode{
        if(darkenBackground){
            showShadedBackground()
        }
        layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        layer.position = CGPoint(x:CCDirector.sharedDirector().viewSize().width/2,y:CCDirector.sharedDirector().viewSize().height)
        if(currentLayer != nil){
            currentLayer!.runAction(CCActionSequence(one: hideAction, two: CCActionCallBlock(block: { () -> Void in
                if(self.currentLayer?.parent != nil){
                    self.currentLayer?.removeFromParent()
                }
            })))
            
        }
        currentLayer = layer
        if(currentMainNode != nil && currentLayer != nil){
            if(!allowBackgroundTouches){
                disableTouchForNode(currentMainNode!)
            }
            currentLayer!.zOrder = 999
            currentScene!.addChild(layer)
            currentLayer!.runAction(showAction)
            
        }
        return layer
    }
    
    func hideLayer(){
        if(currentLayer != nil){
            currentLayer!.runAction(CCActionSequence(one: hideAction, two: CCActionCallBlock(block: { () -> Void in
                if(self.currentLayer?.parent != nil){
                    self.currentLayer?.removeFromParent()
                }
                self.currentLayer = nil
                if(self.shadowBackground.parent != nil){
                    self.hideShadedBackground()
                }
                self.enableTouchForNode(self.currentMainNode!)
            })))
        }
    }
    
    func disableTouchForNode(node:CCNode){
        node.userInteractionEnabled = false;
        if(node.children != nil){
            for child in node.children!{
                disableTouchForNode(child as! CCNode)
            }
        }
    }
    func enableTouchForNode(node:CCNode){
        node.userInteractionEnabled = true;
        if(node.children != nil){
            for child in node.children!{
                enableTouchForNode(child as! CCNode)
            }
        }
    }

    
}