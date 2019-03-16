//
//  SpriteComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    
    let node: SKNode
    
    init(textureName: String) {
        let texture = SKTexture(imageNamed: textureName)
        let spriteNode = SKSpriteNode(texture: texture)
        node = spriteNode
        super.init()
    }
    
    init(node: SKNode) {
        self.node = node
        super.init()
    }
    
    override func didAddToEntity() {
        node.entity = entity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
