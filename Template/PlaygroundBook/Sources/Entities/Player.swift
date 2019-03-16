//
//  Player.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class Player: InteractiveEntity {
    
    override init(textureName: String) {
        super.init(textureName: textureName)
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
