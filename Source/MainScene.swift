import Foundation

class MainScene: CCNode {

    
    func continuous(){
        SceneManager.instance.showScene("GameScene")
    }
    
    func win(){
        SceneManager.instance.showScene("GameScene")
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
   
    
}
