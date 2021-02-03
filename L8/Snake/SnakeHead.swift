//
//  SnakeHead.swift
//  L8
//
//  Created by Владимир on 23.01.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    
    override init(atPoin point: CGPoint) {
        super.init(atPoin: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.Apple | CollisionCategories.EdgeBody
        //EdgeBody ?? 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
