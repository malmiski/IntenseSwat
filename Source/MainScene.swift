import Foundation

@available(iOS 8.0, *)
class MainScene: CCNode {

    
    func continuous(){
        SceneManager.instance.showGameSceneContinuous();
        AudioManager.instance.stopBackgroundMusic()
    }

    func highscores(){
        SceneManager.instance.currentScene = CCDirector.sharedDirector().runningScene
        SceneManager.instance.currentMainNode = self
        SceneManager.instance.showLayer(HighscoreLayer(), allowBackgroundTouches: false)
        
        //SceneManager.instance.showScene("ScrollScene")
    }
    
    func play(){
        SceneManager.instance.showScene("GameScene")
        AudioManager.instance.stopBackgroundMusic()
    }
    
    func camera(){
        SceneManager.instance.showScene("CameraScene")
    }
   
    func didLoadFromCCB(){
        CoreDataController.instance;
        AudioManager.instance.startBackgroundMusic()
    }
    
}
