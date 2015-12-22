//
//  UserImage.swift
//  IntenseSwat
//
//  Created by Basement on 12/18/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation
import CoreData


class UserImage: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    // This function will save the pictures set to the user image to core data
    func savePicture(image:UIImage){
        self.imageData = UIImagePNGRepresentation(image)
        CoreDataController.instance.save()
    }
    // This will load the picture set to the user image, if there
    // is no picture data it will return nil
    func loadPicture() -> UIImage?{
        if imageData != nil{
            let data = self.imageData!;
            let image = UIImage(data: data)!
            return image
        }
        return nil
    }
    
}
/*
// This function will save the pictures set to the user image to the filesystem
func savePicture(image:UIImage){
let imageData = UIImagePNGRepresentation(image)
let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
let docURL = urls[urls.endIndex-1]
let url = docURL.URLByAppendingPathComponent("\(NSUUID().UUIDString).png")
self.imagePath = url.path!
imageData!.writeToFile(self.imagePath!, atomically: false)
CoreDataController.instance.save()
}
// This will load the picture set to the user image, if there
// is no picture data it will return nil
func loadPicture() -> UIImage?{
if imagePath != nil{
let image = UIImage(contentsOfFile: imagePath!)!
return image
}
return nil
}
*/