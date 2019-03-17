//
//  MoveAgentComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

class MoveAgentComponent: GKAgent2D, GKAgentDelegate {
    
    let entityManager: EntityManager
    
    init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.maxAcceleration = maxAcceleration
        self.radius = radius
//        print(self.mass)
        self.mass = 0.01
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node else {
            fatalError("Agent has no SpriteComponent.")
        }
        self.position = vector_float2(point: spriteNode.position)
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node else {
            fatalError("Agent has no SpriteComponent.")
        }
        spriteNode.position = CGPoint(vector: position)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
