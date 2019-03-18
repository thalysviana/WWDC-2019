//
//  FollowBehavior.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit
import GameplayKit

class FollowBehavior: GKBehavior {
    
    var seekGoal: GKGoal?
    
    var stopGoal = GKGoal(toReachTargetSpeed: 0)
    
    init(targetSpeed: Float) {
        super.init()
    }
    
    func start(with agent: GKAgent) {
        setWeight(0.0, for: stopGoal)
        if seekGoal == nil {
            seekGoal = GKGoal(toSeekAgent: agent)
            
        }
        setWeight(1.0, for: seekGoal!)
    }
    
    func stop() {
        if let seekGoal = seekGoal {
            setWeight(0, for: seekGoal)
        }
        setWeight(1.0, for: stopGoal)
    }
    
}
