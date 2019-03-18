//
//  Goalkeeper.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit
import GameplayKit

public class Goalkeeper: InteractiveEntity {
    
    lazy var physicsComponent: PhysicsComponent = {
        guard let component = self.component(ofType: PhysicsComponent.self) else {
            fatalError("Erro ao carregar \(PhysicsComponent.self)")
        }
        return component
    }()
    
    override init(textureName: String) {
        super.init(textureName: textureName)
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        
        let body = SKPhysicsBody(circleOfRadius: spriteComponent.node.frame.width/2)
        body.isDynamic = false
        let physicsComponent = PhysicsComponent(node: spriteComponent.node, body: body)
        
        addComponent(spriteComponent)
        addComponent(physicsComponent)
//        addComponent(NaiveDefenseComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(spriteComponent.node.frame.width) * 0.3))
    }
    
    func addNaiveDefense() {
        let initialMovement = SKAction.moveBy(x: 150, y: 0, duration: 1)
        let rightBackMovement = initialMovement.reversed()
        let leftMovement = SKAction.moveBy(x: -150, y: 0, duration: 1)
        let leftBackMovement = leftMovement.reversed()
        let sequence = SKAction.sequence([initialMovement, rightBackMovement, leftMovement, leftBackMovement])
        let repeatAction = SKAction.repeatForever(sequence)
        
        spriteComponent.node.run(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
