//
//  Tile.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import SpriteKit
import GameplayKit

class Tile: GKEntity {    
    private(set) var tileType: TileType

    init(forTileType tileType: TileType, position: CGPoint) {
        self.tileType = tileType
        
        super.init()
        
        let color = tileType.color()
        let vc = VisualComponent(position: position, color: color)
        vc.sprite.zPosition = EntityLayer.Tile.rawValue
        addComponent(vc)
    }    
}