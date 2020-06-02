//
//  LoseScene.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
import SpriteKit

class LoseScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.white
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.black
        label.fontSize = 30
        label.text = "You Lose"
        label.position =  CGPoint(x:self.frame.midX, y:self.frame.midY);
        self.addChild(label)
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
} //loseScene
