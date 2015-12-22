//
//  CameraScene.swift
//  IntenseSwat
//
//  Created by Basement on 11/27/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

class CameraScene: CCNode, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    weak var backgroundNode:CCNodeColor?
    weak var pictureFrame:CCNodeColor?
    func save(){
    
    }
    
    func choosePhoto(){
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        var sourceType:UIImagePickerControllerSourceType
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            sourceType = .Camera
        }else{
            sourceType = .PhotoLibrary
        }
        imagePicker.sourceType = sourceType
        CCDirector.sharedDirector().presentViewController(imagePicker, animated: true, completion: nil)//addChildViewController(imagePicker)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let rect:CGRect = CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width:pictureFrame!.contentSize.width-30,height:pictureFrame!.contentSize.height-30))
        UIGraphicsBeginImageContext(rect.size)
        image.drawInRect(rect)
        let cgImageData = UIGraphicsGetImageFromCurrentImageContext().CGImage!;
        let texture:CCTexture = CCTexture(CGImage: cgImageData, contentScale:1.0)
        UIGraphicsEndImageContext()
        pictureFrame!.removeAllChildren()
        let picture = CCSprite(texture: texture)
        picture.anchorPoint = CGPoint(x:0.5,y:0.5)
        picture.position = CGPoint(x:pictureFrame!.contentSize.width/2,y:pictureFrame!.contentSize.height/2)
        pictureFrame!.addChild(picture)
        
        // Save the new image to core data for future reference
        let userImage = CoreDataController.instance.loadUserImage()
        userImage.savePicture(UIImage(CGImage: cgImageData))
        CoreDataController.instance.save()
        
        CCDirector.sharedDirector().dismissViewControllerAnimated(true, completion: nil)
    }
    
    func back(){
        SceneManager.instance.showScene("MainScene")
    }
    
    func didLoadFromCCB(){
        let userImage = CoreDataController.instance.loadUserImage()
        print("The user is \(userImage.description)")
        let image = userImage.loadPicture()
        print("The image is \(image?.description)")
        if(image != nil){
            let texture = CCTexture(CGImage: image!.CGImage!, contentScale: 1)
            let sprite = CCSprite(texture: texture)
            pictureFrame!.removeAllChildren()
            sprite.anchorPoint = CGPoint(x:0.5,y:0.5)
            sprite.position = CGPoint(x:pictureFrame!.contentSize.width/2,y:pictureFrame!.contentSize.height/2)
            pictureFrame!.addChild(sprite)
        }
        
    }
    
}