//
//  GameMenu.swift
//  IntenseSwat
//
//  Created by Basement on 12/20/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation
class GameMenu: CCNode
{
    
    func didLoadFromCCB()
    {
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
    
    func back()
    {
        SceneManager.instance.hideLayer()
    }
    func quit()
    {
        back()
// TODO: Implement this method
//        SceneManager.instance.endGame()
    }
    
    func showMenu()
    {
        let scrollNode:CCScrollView = self.parent! as! CCScrollView
        scrollNode.contentNode = self
        scrollNode.contentSizeType = CCSizeType(widthUnit: .Points, heightUnit: .Points)
        self.contentSize = CGSize(width: CCDirector.sharedDirector().viewSize().width, height: 1440)//CGFloat(16*highscores.count*30))
        self.position = CGPoint(x:0,y:0)
        
        
        print(self.contentSize)
    }
    
    
}