import Foundation

class MainScene: CCNode {

    
    func continuous(){
        //SceneManager.instance.showScene("GameScene")
        SceneManager.instance.showGameSceneContinuous();
    }
    
    func win(){
        SceneManager.instance.showGameSceneWin()
    }
    
    func highscores(){
        SceneManager.instance.showScene("ScrollScene")
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
