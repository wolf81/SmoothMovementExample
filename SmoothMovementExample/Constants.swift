//
//  Constants.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import SpriteKit

// Z-positions of entities. 
enum EntityLayer: CGFloat {
    case Tile = 1
    case Hero = 100
}

// For the example we have 2 tile types. No tile (floor) or wall. Walls block Hero movement.
enum TileType: Int {
    case None = 0
    case Wall = 1
    
    func color() -> SKColor {
        var color: SKColor
        
        switch self {
        case .None: color = SKColor.lightGrayColor()
        case .Wall: color = SKColor.darkGrayColor()
        }
        
        return color
    }
}

// The length of a world unit. 
let wuLength: Int = 35
