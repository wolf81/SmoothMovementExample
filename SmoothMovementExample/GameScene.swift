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

    // MARK: - Overrides 
    
    override func didMoveToView(view: SKView) {
        Game.sharedInstance.configureForScene(self)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        moveHeroToTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        moveHeroToTouches(touches)
    }

    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        // Implement as needed, e.g. stop move player character.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Implement as needed, e.g. stop move player character.
    }
   
    override func update(currentTime: CFTimeInterval) {
        // NOTE: The following code is not relevant for the example project, but it's a basic
        //  implementation for an update loop that makes use of the game singleton.
        
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
    
    // MARK: - Private
    
    private func moveHeroToTouches(touches: Set<UITouch>) {
        for touch in touches {
            let location = touch.locationInNode(self)
            Game.sharedInstance.moveHeroToLocation(location)
        }
    }
}
