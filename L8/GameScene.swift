//
//  GameScene.swift
//  L8
//
//  Created by Владимир on 21.01.2021.
//

import SpriteKit
import GameplayKit


struct CollisionCategories {
    
    static let Snake:       UInt32 = 0x1 << 0
    static let SnakeHead:   UInt32 = 0x1 << 1
    static let Apple:       UInt32 = 0x1 << 2
    static let EdgeBody:    UInt32 = 0x1 << 3
}


class GameScene: SKScene {
    
    var snake: Snake?
    var gameOver = SKLabelNode(text: "GAME OVER")
    var flagGame = true
    
    
    override func didMove(to view: SKView) {
    
        backgroundColor = SKColor.black
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        let counterClockWiseButton = SKShapeNode()
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockWiseButton.fillColor = UIColor.gray
        counterClockWiseButton.strokeColor = UIColor.gray
        counterClockWiseButton.lineWidth = 10
        counterClockWiseButton.name = "counterClockWiseButton"
        self.addChild(counterClockWiseButton)
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30)
        clockWiseButton.fillColor = UIColor.gray
        clockWiseButton.strokeColor = UIColor.gray
        clockWiseButton.lineWidth = 10
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        
        createApple()

        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.allowsRotation = false
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.SnakeHead | CollisionCategories.Snake
        
        
        gameOver.position = CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY)
        gameOver.alpha = 0
        self.addChild(gameOver)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "clockWiseButton" || touchNode.name == "counterClockWiseButton" else {
                return
            }
            touchNode.fillColor = .green
            
            if flagGame {
                if touchNode.name == "counterClockWiseButton" {
                    snake!.moveCounterClockwise()
                } else if touchNode.name == "clockWiseButton" {
                    snake!.moveClockwise()
                }
            } else {
                flagGame = true
                if touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" {
                    gameOver.alpha = 0
                    snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
                    self.addChild(snake!)
                }
            }
        }
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "clockWiseButton" || touchNode.name == "counterClockWiseButton" else {
                return
            }
            touchNode.fillColor = .gray
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
             
        case CollisionCategories.EdgeBody:
            flagGame = false
            snake?.removeFromParent()
            gameOver.run(SKAction.fadeIn(withDuration: 0.1))

                        
        default:
            break
        }
    }
}
