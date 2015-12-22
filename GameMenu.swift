//
//  GameMenu.swift
//  IntenseSwat
//
//  Created by Basement on 12/20/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation
class GameMenu: CCNode{
    
    func didLoadFromCCB(){
        // Just scale it to account for the difference between points
        // and pixels
        self.scale = Float(CCDirector.sharedDirector().viewSize().width/CCDirector.sharedDirector().viewSizeInPixels().width)
        
    }
    
    /*
    Not needed
    
    // Function workaround for getting real content size
    func getContentSize()->CGSize{
        let child = self.children.first! as! CCNode
        return child.boundingBox().size
    }
    */
    
    func hideMenu(){
        SceneManager.instance.hideLayer()
    }
    func quitGame(){
        hideMenu()
// TODO: Implement this method
//        SceneManager.instance.endGame()
    }
}