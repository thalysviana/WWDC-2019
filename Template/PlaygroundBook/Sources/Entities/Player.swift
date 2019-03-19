//
//  Player.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class Player: InteractiveEntity {
    
    override init(textureName: String = "soccer_player_back") {
        super.init(textureName: textureName)
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        addComponent(spriteComponent)
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: Float(spriteComponent.node.frame.width) * 0.3))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
