//
//  GameScene.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

@available(iOS 8.0, *)
class GameScene: CCNode{
    weak var backgroundNode:CCNode?
    let size = CCDirector.sharedDirector().viewSizeInPixels()
    let sizeInPoints = CCDirector.sharedDirector().viewSize()
    let hudStatusBar = CCBReader.load("HUDStatusBar") as! HUDStatusBar
    var flies:[FlyingFly] = []
    var countTime = false
    var gameRunning = true
    
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
        // Initialize GameManager with this game scene
        GameManager.sharedInstance.setCurrentScene(self)
    }
/*
    func back(){
//      Code to return to the main menu
        endGame();
        SceneManager.instance.showMainScene()
    }
*/
    func cleanup(){
    
    }
    
    func endGame(){
//      This will set off a series of events that will lead to the end of the game, and the saving of scores
        //SceneManager.instance.showMainScene()
        gameRunning = false
        self.pauseGame()
        // Show the GameFinishLayer to tell the player they died, and how well they did
        let finishLayer = GameFinishLayer()
        finishLayer.updateScores(hudStatusBar.flies, timeValue: hudStatusBar.time, scoreValue: hudStatusBar.score);
        SceneManager.instance.showLayer(finishLayer)
        
        updateHighscores(hudStatusBar.score, timeVal: hudStatusBar.time, fliesVal: hudStatusBar.flies)
        
    }
    func updateHighscores(scoreVal:Int, timeVal:Double, fliesVal:Int){
        let highscores:[Highscores] = CoreDataController.instance.getHighscores()
        var shouldInsert:Bool = true
        if let last = highscores.last {
            if last.score!.integerValue > scoreVal || highscores.count < 3{
             shouldInsert = false
            }
        }
        if(shouldInsert){
            CoreDataController.instance.saveHighscore(scoreVal, time:timeVal, flies:fliesVal)
        }
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
        AudioManager.instance.playSwatterSwatting()
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
                hudStatusBar.flies += 1
                hudStatusBar.score += 15
                return false
            }
            return true
        })
    }
    func withinSwatter(position:CGPoint)->Bool{
        var position = position;
        position.x = position.x - swatter!.position.x
        position.y = position.y - swatter!.position.y

        if(position.x <= node_4!.position.x && position.x >= node_1!.position.x){
            if(position.y<=node_2!.position.y && position.y>=node_3!.position.y){
            return true
            }
        }
        
        return false
    }

    var startTimer:CCNode?=nil
    // This is called when the continuous option is selected
    func startContinuous(){
        // Until the start timer finishes, then we won't allow touches to be registered on the main node
        SceneManager.instance.disableTouchForNode(self)
        SceneManager.instance.disableTouchForNode(SceneManager.instance.hud)
        
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
        gameRunning = true
        SceneManager.instance.enableTouchForNode(self)
        SceneManager.instance.enableTouchForNode(SceneManager.instance.hud)
        //TODO: Begin to populate the screen with flies, increment the time every second, and calculate the score
        countTime = true
        performSelector(#selector(GameScene.incrementTime),withObject: self,afterDelay: 0.1)
        unpauseAllFlies()
        continuousFlyGeneration()
    }
    func continuousFlyGeneration(){
        if(countTime && gameRunning){
            genFly()
            performSelector(#selector(GameScene.continuousFlyGeneration), withObject:self, afterDelay:CCTime(FlyingFly.randomFloat()*2))
        }
    }
    
    func incrementTime(){
        if(countTime && gameRunning){
            self.hudStatusBar.time += 0.1
            performSelector(#selector(GameScene.incrementTime),withObject: self,afterDelay: 0.1)
        }
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
        }else if(gameRunning){
            endGame();
        }
    }
    
    func pauseGame(){
        pauseAllFlies()
        gameRunning = false
        
    }
    
    func unpauseGame(){
        SceneManager.instance.hud.addChild(startTimer!)
        SceneManager.instance.disableTouchForNode(self)
        SceneManager.instance.disableTouchForNode(SceneManager.instance.hud)
        startTimer!.animationManager!.runAnimationsForSequenceNamed("CountdownTimeline")
    }
    
    // Pause all flies actions currently on them
    func pauseAllFlies(){
        for i in (0 ..< flies.count) {
            flies[i].paused = true
            flies[i].pauseBuzzing()
            //flies[i].stopAllActions()
        }
    }
    func unpauseAllFlies(){
        for i in (0 ..< flies.count) {
            flies[i].paused = false
            flies[i].continueBuzzing()
        }
    }
}