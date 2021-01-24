//
//  SnakeBodyPart.swift
//  L8
//
//  Created by Владимир on 23.01.2021.
//

import UIKit
import SpriteKit

class SnakeBodyPart : SKShapeNode {
    
    let diametr = 10
    
    init(atPoin point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = UIColor.green
        strokeColor = UIColor.green
        lineWidth = 5
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x: 5, y: 5))
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.SnakeHead | CollisionCategories.Apple
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
