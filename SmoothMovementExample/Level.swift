//
//  Level.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import SpriteKit

class Level {
    
    // PLEASE NOTE: Perhaps it's better to use GKGridGraph instead, but I haven't much experience
    //  with this class yet, so I've resorted to a custom solution.
    
    // The grid has a horizontal world unit count of 7, a vertical world unit count of 8. 
    let hWuCount = 10
    let vWuCount = 10

    // The configuration for the level. The grid uses tile types as defined in the constants file.
    let grid = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                1, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 1, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 1, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 1, 0, 0, 1,
                1, 0, 1, 1, 1, 1, 1, 0, 0, 1,
                1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
                1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    
    // Hero start position.
    let heroPos = int2(x: 4, y: 4)
    
    func tileTypeAtGridPosition(pos: int2) -> TileType {
        let idx: Int = ((vWuCount - 1) - Int(pos.y)) * hWuCount + Int(pos.x)
        let i = grid[idx]
        return TileType(rawValue: i)!
    }
}