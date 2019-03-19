//
//  Defender.swift
//  Book_Sources
//
//  Created by Thalys Viana on 18/03/19.
//

import SpriteKit
import GameplayKit

public class Defender: InteractiveEntity {
    
    override init(textureName: String = "defender_front") {
        super.init(textureName: textureName)
        
        let texture = SKTexture(imageNamed: textureName)
        let spriteComponent = SpriteComponent(textureName: textureName)
        let body = SKPhysicsBody(texture: texture, size: spriteComponent.node.size)
        let physicsComponent = PhysicsComponent(node: spriteComponent.node, body: body)
        
        body.isDynamic = false
        
        addComponent(spriteComponent)
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(spriteComponent.node.frame.width) * 0.3))
        addComponent(physicsComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
