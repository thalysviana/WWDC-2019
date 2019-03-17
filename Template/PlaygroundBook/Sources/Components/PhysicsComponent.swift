//
//  PhysicsComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class PhysicsComponent: GKComponent {
    
    let body: SKPhysicsBody
    
    init(node: SKNode, body: SKPhysicsBody) {
        self.body = body
        node.physicsBody = body
        node.physicsBody?.affectedByGravity = false
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
