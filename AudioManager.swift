//
//  AudioManager.swift
//  IntenseSwat
//
//  Created by Basement on 7/17/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation
class AudioManager{
    static var instance = AudioManager();
    let flySquishing:ALBuffer!
    let swatterSwatting:ALBuffer!
    let flyBuzzLoop:ALBuffer!
    
    private  init(){
        _ = OALSimpleAudio.sharedInstance().preloadBg("onett.mp3")
        flySquishing = OALSimpleAudio.sharedInstance().preloadEffect("flySquish.wav")
        flyBuzzLoop = OALSimpleAudio.sharedInstance().preloadEffect("flyBuzz.wav")
        swatterSwatting = OALSimpleAudio.sharedInstance().preloadEffect("swatterSwatting.wav")
    }
    
    func startBackgroundMusic(){
        OALSimpleAudio.sharedInstance().playBgWithLoop(true);
    }
    
    func stopBackgroundMusic(){
        OALSimpleAudio.sharedInstance().stopBg()
    
    }
    func stopEverything(){
        OALSimpleAudio.sharedInstance().stopEverything()
    }
    
    func playFlySquishing() -> ALSoundSource!{
        return OALSimpleAudio.sharedInstance().playBuffer(flySquishing, volume: 1.0, pitch: 1.0, pan: 0.0, loop: false)
    }
    func playSwatterSwatting() -> ALSoundSource!{
        return OALSimpleAudio.sharedInstance().playBuffer(swatterSwatting, volume: 1.0, pitch: 1.0, pan: 0.0, loop: false)
    }
    func playFlyBuzz() -> ALSoundSource!{
        return OALSimpleAudio.sharedInstance().playBuffer(flyBuzzLoop, volume: 1.0, pitch: 1.0, pan: 0.0, loop: true)
    }

    

}
