//
//  FollowComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit
import GameplayKit

class FollowComponent: MoveComponent {
    
    let agent: PursuedComponent
    
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, seek agent: PursuedComponent) {
        self.agent = agent
        super.init(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: radius)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if behavior == nil {
            let goal = GKGoal(toInterceptAgent: agent, maxPredictionTime: 0)
            behavior = GKBehavior(goal: goal, weight: 1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
