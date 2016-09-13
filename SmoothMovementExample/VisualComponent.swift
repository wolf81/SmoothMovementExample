//
//  VisualComponent.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import GameplayKit
import SpriteKit

class VisualComponent: GKComponent {
    private(set) var sprite: SKSpriteNode

    private(set) var isMoving = false
    
    var gridPosition: int2 {
        let position = CGPoint(x: CGFloat(sprite.position.x), y: CGFloat(sprite.position.y))
        return Game.sharedInstance.gridPositionForPosition(position)
    }
    
    init(position: CGPoint, color: SKColor) {
        let size = CGSize(width: wuLength, height: wuLength)
        
        sprite = SKSpriteNode(color: color, size: size)
        sprite.position = position
        
        super.init()
    }
    
    func moveToGridPosition(gridPosition: int2, completion block: () -> Void) {
        if isMoving {
            return
        }

        isMoving = true
        
        let pos = Game.sharedInstance.positionForGridPosition(gridPosition)
        let move = SKAction.moveTo(pos, duration: 0.5)
        
        sprite.runAction(move) {
            self.isMoving = false            
            block()
        }        
    }
}
