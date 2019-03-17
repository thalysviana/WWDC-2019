//
//  FollowAgentComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

class FollowAgentComponent: MoveAgentComponent {
    
    override init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        super.init(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: radius, entityManager: entityManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
