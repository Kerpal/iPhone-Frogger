//
//  MusicPlayer.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
import AVFoundation

var SoundInstance = MusicPlayer()

open class MusicPlayer {
    
    var backgroundMusicPlayer: AVAudioPlayer!
    
    init() {
        let url = Bundle.main.url(forResource: "music", withExtension: "wav")
        do {
            try backgroundMusicPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("Could not create audio player")
        }
        
        backgroundMusicPlayer!.numberOfLoops = -1
        backgroundMusicPlayer!.prepareToPlay()
    }
    
    open func playMusic() {
        backgroundMusicPlayer.play()
        musicPlaying = true
    }
    
    open func stopMusic() {
        if (backgroundMusicPlayer != nil && backgroundMusicPlayer!.isPlaying) {
            backgroundMusicPlayer.currentTime = 0
            backgroundMusicPlayer.stop()
            musicPlaying = false
        }
    }
    
    open func resumeMusic() {
        if (backgroundMusicPlayer != nil && !backgroundMusicPlayer!.isPlaying) {
            backgroundMusicPlayer.play()
            musicPlaying = true
        }
    }
    
    open class func sharedInstance() -> MusicPlayer {
        return SoundInstance
    }
    
    
}
