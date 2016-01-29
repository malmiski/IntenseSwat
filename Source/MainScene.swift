import Foundation

class MainScene: CCNode {

    
    func continuous(){
        SceneManager.instance.showGameSceneContinuous();
    }

    func highscores(){
        SceneManager.instance.currentScene = CCDirector.sharedDirector().runningScene
        SceneManager.instance.currentMainNode = self
        SceneManager.instance.showLayer(HighscoreLayer(), allowBackgroundTouches: false)
        
        //SceneManager.instance.showScene("ScrollScene")
    }
    
    func play(){
        SceneManager.instance.showScene("GameScene")
    }
    
    func camera(){
        SceneManager.instance.showScene("CameraScene")
    }
   
    func didLoadFromCCB(){
        CoreDataController.instance;
    }
    
}
