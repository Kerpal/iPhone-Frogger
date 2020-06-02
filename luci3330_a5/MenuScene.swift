//
//  MenuScene.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    var playLabel : SKLabelNode?
    var musicPlayLabel : SKLabelNode?
    var musicStopLabel : SKLabelNode?
    
    var music = MusicPlayer.sharedInstance()
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.white
        
        let frog = SKSpriteNode(imageNamed: "frog")
        frog.position = CGPoint(x: self.frame.midX, y: self.frame.midY+250)
        frog.anchorPoint = CGPoint(x: 0.5, y: 1)
        addChild(frog)
        
        playLabel = SKLabelNode(fontNamed: "Courier")
        playLabel!.fontColor = SKColor.black
        playLabel!.fontSize = 30
        playLabel!.text = "Play"
        playLabel!.name = "Play"
        playLabel!.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+90);
        self.addChild(playLabel!)
        
        musicPlayLabel = SKLabelNode(fontNamed: "Courier")
        musicPlayLabel!.fontColor = SKColor.black
        musicPlayLabel!.fontSize = 18
        musicPlayLabel!.text = "Play Music"
        musicPlayLabel!.name = "Play Music"
        musicPlayLabel!.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+30);
        self.addChild(musicPlayLabel!)
        
        musicStopLabel = SKLabelNode(fontNamed: "Courier")
        musicStopLabel!.fontColor = SKColor.black
        musicStopLabel!.fontSize = 18
        musicStopLabel!.text = "Stop Music"
        musicStopLabel!.name = "Stop Music"
        musicStopLabel!.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-30);
        self.addChild(musicStopLabel!)
        
    } //init
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            if theNode.name == playLabel!.name {
                print("The \(playLabel!.name!) is touched ")
                let transition = SKTransition.doorway(withDuration: 1.0)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            else if theNode.name == musicPlayLabel!.name {
                print("The \(musicPlayLabel!.name!) is touched")
                music.playMusic()
            }
            else if theNode.name == musicStopLabel!.name {
                print("The \(musicStopLabel!.name!) is touched")
                music.stopMusic()
            }
            // println("touch outside")
        }
    } //touchesBegan
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
