//
//  Game.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright © 2016 Wolftrail. All rights reserved.
//

import SpriteKit
import GameplayKit

class Game {
    static let sharedInstance = Game()

    private let level = Level()
    
    private var tiles = [Tile]()
    private var hero: Hero!
    
    private weak var scene: SKScene?
    
    private init() {
        // Initializer hidden, since this is a singleton. Use sharedInstance() instead.
    }
    
    func configureForScene(scene: SKScene) {
        self.scene = scene

        self.scene?.backgroundColor = SKColor.whiteColor()
                
        for gridY in (0 ..< level.vWuCount) {
            for gridX in (0 ..< level.hWuCount) {
                let gridPos = int2(Int32(gridX), Int32(gridY))
                let tileType = level.tileTypeAtGridPosition(gridPos)
                
                let pos = positionForGridPosition(gridPos)
                let tile = Tile(forTileType: tileType, position: pos)
                addEntity(tile)
            }
        }
        
        let pos = positionForGridPosition(level.heroPos)
        hero = Hero(position: pos)
        addEntity(hero)
    }
    
    func updateWithDeltaTime(seconds: CFTimeInterval) {
        // Update game systems, state, add and remove entities, etc... here.
    }
    
    func positionForGridPosition(gridPosition: int2) -> CGPoint {
        guard let scene = self.scene else {
            return CGPoint(x: -1, y: -1)
        }
        
        let sceneWidth = CGRectGetWidth(scene.frame)
        let sceneHeight = CGRectGetHeight(scene.frame)

        let offset = wuLength / 2
        let originX = (Int(sceneWidth) - level.hWuCount * wuLength) / 2 + offset
        let originY = (Int(sceneHeight) - level.vWuCount * wuLength) / 2 + offset

        let x = originX + Int(gridPosition.x) * wuLength
        let y = originY + Int(gridPosition.y) * wuLength

        return CGPoint(x: Int(x), y: Int(y))
    }
    
    func gridPositionForPosition(position: CGPoint) -> int2 {
        guard let scene = self.scene else {
            return int2(-1, -1)
        }
        
        let sceneWidth = CGRectGetWidth(scene.frame)
        let sceneHeight = CGRectGetHeight(scene.frame)
        
        let offset = wuLength / 2
        let originX = (Int(sceneWidth) - level.hWuCount * wuLength) / 2 - offset
        let originY = (Int(sceneHeight) - level.vWuCount * wuLength) / 2 - offset

        let x = (Int(position.x) - originX) / wuLength
        let y = (Int(position.y) - originY) / wuLength
        
        return int2(Int32(x), Int32(y))
    }
    
    func moveHeroToLocation(location: CGPoint) {
        let gridPos = gridPositionForPosition(location)
        hero.moveToGridPosition(gridPos)
    }
    
    func canMoveToGridPosition(gridPosition: int2) -> Bool {
        return level.tileTypeAtGridPosition(gridPosition) == .None
    }
    
    // MARK: - Private
        
    private func addEntity(entity: GKEntity) {
        switch entity {
        case is Tile: tiles.append(entity as! Tile)
        case is Hero: hero = entity as! Hero
        default: break
        }
        
        if let vc = entity.componentForClass(VisualComponent) {
            scene?.addChild(vc.sprite)
        }
    }
}