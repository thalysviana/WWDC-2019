//
//  GameScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class InitialScene: SKScene {
    
    private var entityManager: EntityManager!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        entityManager = EntityManager(scene: self)
        
        let player = Player(textureName: "character")
        addChild(player.spriteComponent.node)
        
        player.spriteComponent.node.position = CGPoint(x: frame.midX, y: frame.midY)
        
        entityManager.add(player)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
