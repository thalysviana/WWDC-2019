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
    
    let seek: GKEntity
    
    init(textureName: String, seek: GKEntity) {
        self.seek = seek
        super.init(textureName: textureName)
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        
        let body = SKPhysicsBody(circleOfRadius: spriteComponent.node.frame.width/2)
        body.isDynamic = false
        let physicsComponent = PhysicsComponent(node: spriteComponent.node, body: body)
        
        addComponent(spriteComponent)
        addComponent(physicsComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
