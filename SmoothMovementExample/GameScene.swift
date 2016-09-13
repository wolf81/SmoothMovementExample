//
//  GameScene.swift
//  SmoothMovementExample
//
//  Created by Wolfgang Schreurs on 13/09/16.
//  Copyright (c) 2016 Wolftrail. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    // The previous update time is used to calculate the delta time. The delta time is used to
    //  update the Game state.
    private var lastUpdateTime: NSTimeInterval = 0

    override func didMoveToView(view: SKView) {
        Game.sharedInstance.configureForScene(self)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // start move to destination
        for touch in touches {
            let location = touch.locationInNode(self)
            Game.sharedInstance.moveHeroToLocation(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // update destination
        for touch in touches {
            let location = touch.locationInNode(self)
            Game.sharedInstance.moveHeroToLocation(location)
        }
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        // stop move
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // stop move
    }
   
    override func update(currentTime: CFTimeInterval) {
        // NOTE: After pausing the game, the last update time is reset to the current time. The
        //  next time the update loop is entered, a correct delta time can then be calculated using
        //  the current time and the last update time.
        if lastUpdateTime <= 0 {
            lastUpdateTime = currentTime
        } else {
            let deltaTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
            Game.sharedInstance.updateWithDeltaTime(deltaTime)
        }
    }
}
