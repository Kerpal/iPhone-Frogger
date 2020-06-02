//
//  WinScene.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
import SpriteKit

class WinScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.white
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.black
        label.fontSize = 30
        label.text = "You win"
        label.position =  CGPoint(x:self.frame.midX, y:self.frame.midY+10);
        self.addChild(label)
        
        let label2 = SKLabelNode(fontNamed: "Courier")
        label2.fontColor = SKColor.black
        label2.fontSize = 14
        label2.text = "Going back to menu..."
        label2.position =  CGPoint(x:self.frame.midX, y:self.frame.midY-10);
        self.addChild(label2)
        
        let secondsToDelay = 3.0
            perform(#selector(loadMenu), with: nil, afterDelay: secondsToDelay)
            
    } //init
        
    @objc func loadMenu() {
        print("menu")
        let transition = SKTransition.flipHorizontal(withDuration: 3)
        let menuScene = MenuScene(size: self.size)
        self.view?.presentScene(menuScene, transition: transition)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} //winScene
