//
//  HUDBottomBar.swift
//  IntenseSwat
//
//  Created by Basement on 12/23/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation
@available(iOS 8.0, *)
class HUDBottomBar:CCNode{
    weak var pauseButton:CCButton?
    weak var resetButton:CCButton?
    weak var muteButton:CCButton?
    
    let size = CCDirector.sharedDirector().viewSize()
    func didLoadFromCCB(){
        pauseButton!.position = CGPoint(x:0.1*size.width,y:0)
        resetButton!.position = CGPoint(x:0.4*size.width,y:0)
        muteButton!.position = CGPoint(x:0.7*size.width,y:0)
    }
    
    func pause(){
        //let gameMenu = CCBReader.load("GameMenu") as! GameMenu
        //SceneManager.instance.showLayer(gameMenu)
        SceneManager.instance.showLayer(PauseLayer())
    }
    
    func reset(){
    
    }
    
    func mute(){
    
    }
}