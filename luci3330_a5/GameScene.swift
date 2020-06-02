//
//  GameScene.swift
//  luci3330_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 wlu. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let frog = SKSpriteNode(imageNamed: "frog")
    let deadfrog = SKSpriteNode(imageNamed: "deadfrog")
    let carLeft = SKSpriteNode(imageNamed: "car1")
    let carRight = SKSpriteNode(imageNamed: "car2")
    let carLeft2 = SKSpriteNode(imageNamed: "car1")
    let carRight2 = SKSpriteNode(imageNamed: "car2")
    let up = SKSpriteNode(imageNamed: "up")
    let down = SKSpriteNode(imageNamed: "down")
    let left = SKSpriteNode(imageNamed: "left")
    let right = SKSpriteNode(imageNamed: "right")
    
    var start : SKShapeNode?
    var end : SKShapeNode?
    
    var hit : Bool?
    var win : Bool?
    
    let buttonRow: CGFloat = 1/14
    let startRow: CGFloat = 2/14
    let leftRow1: CGFloat = 3/14
    let rightRow1: CGFloat = 4/14
    let leftRow2: CGFloat = 5/14
    let rightRow2: CGFloat = 6/14
    let endRow: CGFloat = 7/14
    
    let column1: CGFloat = 1/5
    let column2: CGFloat = 2/5
    let column3: CGFloat = 3/5
    let column4: CGFloat = 4/5
    let column5: CGFloat = 5/5
    
    let leftCarSpeed: Double = 5
    let rightCarSpeed: Double = 7
    let leftCarSpeed2: Double = 4
    let rightCarSpeed2: Double = 6
    
    
    override func didMove(to view: SKView) {
        
        hit = false
        win = false
        backgroundColor = SKColor.white
        
        frog.anchorPoint = CGPoint(x: 0.5, y:1)
        frog.position = CGPoint(x: size.width * 0.5, y: size.height * startRow)
        frog.physicsBody = SKPhysicsBody(rectangleOf: frog.size, center: CGPoint(x: 0.0, y: -frog.size.height/2))
        frog.physicsBody?.isDynamic = true
        frog.physicsBody?.categoryBitMask = PhysicsCategory.Frog
        frog.physicsBody?.contactTestBitMask = PhysicsCategory.Car
        frog.physicsBody?.collisionBitMask = PhysicsCategory.None
        frog.physicsBody?.usesPreciseCollisionDetection = true
        frog.setScale(0.7)
        addChild(frog)
        
        left.position = CGPoint(x: size.width * column1, y: size.height * buttonRow)
        left.anchorPoint = CGPoint(x: 0.5, y: 1)
        left.name = "left"
        addChild(left)
        
        down.position = CGPoint(x: size.width * column2, y: size.height * buttonRow)
        down.anchorPoint = CGPoint(x: 0.5, y: 1)
        down.name = "down"
        addChild(down)
        
        up.position = CGPoint(x: size.width * column3, y: size.height * buttonRow)
        up.anchorPoint = CGPoint(x: 0.5, y: 1)
        up.name = "up"
        addChild(up)
        
        right.position = CGPoint(x: size.width * column4, y: size.height * buttonRow)
        right.anchorPoint = CGPoint(x: 0.5, y: 1)
        right.name = "right"
        addChild(right)
        
        lanes()
        
        addCar(car: carLeft, xpos: 1, ypos: leftRow1)
        addCar(car: carRight, xpos: 0, ypos: rightRow1)
        addCar(car: carLeft2, xpos: 1, ypos: leftRow2)
        addCar(car: carRight2, xpos: 0, ypos: rightRow2)
        
        moveLCars(car: carLeft, speed: leftCarSpeed)
        moveRCars(car: carRight, speed: rightCarSpeed)
        moveLCars(car: carLeft2, speed: leftCarSpeed2)
        moveRCars(car: carRight2, speed: rightCarSpeed2)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    func lanes() {
        start = SKShapeNode(rect: CGRect(x: 0, y: (size.height*(1/14)), width: size.width, height: (size.height*(1/14))))
        start?.name = "start"
        start?.fillColor = SKColor.brown
        addChild(start!)
        
        end = SKShapeNode(rect: CGRect(x: 0, y: (size.height*(7/14)), width: size.width, height: (size.height*(1/14))))
        end?.name = "end"
        end?.fillColor = SKColor.brown
        end!.physicsBody?.categoryBitMask = PhysicsCategory.End
        end!.physicsBody?.collisionBitMask = PhysicsCategory.None
        end!.physicsBody?.contactTestBitMask = PhysicsCategory.Frog
        addChild(end!)
        
    }
    
    func addCar(car: SKSpriteNode, xpos: CGFloat, ypos: CGFloat) {
        if (xpos == 0) {
            car.anchorPoint = CGPoint(x: 0.5, y:0)
        }
        if (xpos == 1) {
            car.anchorPoint = CGPoint(x: 0.5, y:0)
        }
        
        car.position = CGPoint( x:(size.width * CGFloat(xpos) ), y:(size.height * ypos) )
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size, center: CGPoint(x: 0.0, y: car.size.height/2))
        car.physicsBody?.isDynamic = true
        car.physicsBody?.categoryBitMask = PhysicsCategory.Car
        car.physicsBody?.contactTestBitMask = PhysicsCategory.Frog
        car.physicsBody?.collisionBitMask = PhysicsCategory.None
        car.physicsBody?.usesPreciseCollisionDetection = true
        car.setScale(0.8)
        addChild(car)
    }
    
    func moveLCars(car: SKSpriteNode, speed: Double) {
        let leftCars = SKAction.moveTo(x: 0 - carLeft.size.width, duration: speed)
        let loopLeft = SKAction.run() {
            car.position.x = self.frame.size.width + car.size.width
        }
        let carSound = SKAction.playSoundFileNamed("carSound.wav", waitForCompletion: false)
        car.run(SKAction.repeatForever(SKAction.sequence([leftCars, loopLeft, carSound])))
    }
    
    func moveRCars(car: SKSpriteNode, speed: Double) {
        let rightCars = SKAction.moveTo(x: self.frame.size.width + carLeft.size.width, duration: speed)
        let loopRight = SKAction.run() {
            car.position.x = 0 - car.size.width
        }
        let carSound = SKAction.playSoundFileNamed("carSound.wav", waitForCompletion: false)
        car.run(SKAction.repeatForever(SKAction.sequence([rightCars, loopRight, carSound])))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let xMovement = size.width / 5
        let yMovement = size.width / 7
        
        if hit == false && win == false {
            for touch: AnyObject in touches {
                let location = touch.location(in: self)
                let theNode = self.atPoint(location)
                if theNode.name == left.name {
                    print("The \(left.name!) button is touched ")
                    run(SKAction.playSoundFileNamed("frogSound.mp3", waitForCompletion: false))
                    if (frog.position.x > size.width * column1) {
                        frog.position.x -= xMovement
                    }
                }
                else if theNode.name == down.name {
                    print("The \(down.name!) button is touched ")
                    run(SKAction.playSoundFileNamed("frogSound.mp3", waitForCompletion: false))
                    if (frog.position.y > size.height * startRow) {
                        frog.position.y -= yMovement
                    }
                    
                }
                else if theNode.name == up.name {
                    print("The \(up.name!) button is touched ")
                    run(SKAction.playSoundFileNamed("frogSound.mp3", waitForCompletion: false))
                    frog.position.y += yMovement
                }
                else if theNode.name == right.name {
                    print("The \(right.name!) button is touched ")
                    run(SKAction.playSoundFileNamed("frogSound.mp3", waitForCompletion: false))
                    if (frog.position.x < size.width * column4) {
                        frog.position.x += xMovement
                    }
                }
                // println("touch outside")
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if (frog.position.y > (size.height * (7.5)/14)) {
            endReached()
        }
    }
    
    func frogHit(_ frog:SKSpriteNode, car:SKSpriteNode) {
        run(SKAction.playSoundFileNamed("crash.wav", waitForCompletion: true))
        print("Hit")
        hit = true
        frog.texture = SKTexture(imageNamed: "deadfrog")
        loadLose()
     }
    
    func endReached() {
        print("win")
        win = true
        SKAction.wait(forDuration: 2.5)
        loadWin()
            
    }
    
    func loadLose() {
        let loseScene = LoseScene(size: self.size)
        let transition = SKTransition.flipHorizontal(withDuration: 2.0)
        self.view?.presentScene(loseScene, transition: transition)
    }
    
    func loadWin() {
        let winScene = WinScene(size: self.size)
        let transition = SKTransition.flipHorizontal(withDuration: 2.0)
        self.view?.presentScene(winScene, transition: transition)
    }

     
     // we must implement this delegate method
    func didBegin(_ contact: SKPhysicsContact) {
         
         // bodyA and bodyB collide, we have to sort them by their bitmasks
         var firstBody: SKPhysicsBody
         var secondBody: SKPhysicsBody
         if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
             firstBody = contact.bodyA
             secondBody = contact.bodyB
         } else {
             firstBody = contact.bodyB
             secondBody = contact.bodyA
         }
         
         //
         if ((firstBody.categoryBitMask & PhysicsCategory.Frog != 0) &&
             (secondBody.categoryBitMask & PhysicsCategory.Car != 0)) {
                 frogHit(firstBody.node as! SKSpriteNode, car: secondBody.node as! SKSpriteNode)
         }
         
     }
}
