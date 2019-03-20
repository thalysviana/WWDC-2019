//
//  Ball.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class Ball: InteractiveEntity {
    
    lazy var physicsComponent: PhysicsComponent = {
        guard let component = self.component(ofType: PhysicsComponent.self) else {
            fatalError("Erro ao carregar \(PhysicsComponent.self)")
        }
        return component
    }()
    
    override init(textureName: String = "ball") {
        super.init(textureName: textureName)
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        
        let body = SKPhysicsBody(circleOfRadius: spriteComponent.node.frame.width/2)
        setupBallPhysics(body: body)
        
        let physicsComponent = PhysicsComponent(node: spriteComponent.node, body: body)
        
        addComponent(spriteComponent)
        addComponent(physicsComponent)
    }
    
    private func setupBallPhysics(body: SKPhysicsBody) {
        body.restitution = 1
        body.friction = 1
        body.linearDamping = 0
        body.angularDamping = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
