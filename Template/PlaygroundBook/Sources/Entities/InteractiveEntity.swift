//
//  InteractiveEntity.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class InteractiveEntity: GKEntity {
    
    lazy var spriteComponent: SpriteComponent = {
        guard let component = self.component(ofType: SpriteComponent.self) else {
            fatalError("Erro ao carregar \(SpriteComponent.self)")
        }
        return component
    }()
    
    init(textureName: String) {
        super.init()
        
        let spriteComponent = SpriteComponent(textureName: textureName)
        addComponent(spriteComponent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
