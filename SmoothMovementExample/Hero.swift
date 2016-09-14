//
//  Hero.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import GameplayKit
import SpriteKit

class Hero: GKEntity {
    
    private(set) var toGridPosition: int2?
    
    var position: CGPoint {
        var pos = CGPoint(x: -1, y: -1)
        
        if let vc = componentForClass(VisualComponent) {
            pos = vc.sprite.position
        }
        
        return pos
    }
    
    init(position: CGPoint) {
        super.init()
        
        let color = SKColor.blueColor()
        let vc = VisualComponent(position: position, color: color)
        vc.sprite.zPosition = EntityLayer.Hero.rawValue
        addComponent(vc)
    }
    
    // MARK: - Overrides
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        guard
            let vc = componentForClass(VisualComponent),
            let toGridPosition = self.toGridPosition else {
                return
        }
        
        let heroPos = vc.gridPosition
        
        // Calculcate distance between hero position and destination in world units.
        let dx = toGridPosition.x - heroPos.x
        let dy = toGridPosition.y - heroPos.y
        
        if dx == 0 && dy == 0 {
            // Stop movement if destination is already reached.
            stopMove()
        } else {
            // Move 1 world unit closer to destination point.
            var nextGridPosition = heroPos
            
            if dx > 0 {
                nextGridPosition.x += 1
            } else if dx < 0 {
                nextGridPosition.x -= 1
            } else if dy > 0 {
                nextGridPosition.y += 1
            } else if dy < 0 {
                nextGridPosition.y -= 1
            }
            
            if Game.sharedInstance.canMoveToGridPosition(nextGridPosition) {
                vc.moveToGridPosition(nextGridPosition)
            }
        }
    }
    
    // MARK: - Public 
    
    func moveToGridPosition(gridPosition: int2?) {
        self.toGridPosition = gridPosition
    }
    
    func stopMove() {
        self.toGridPosition = nil
    }
}
