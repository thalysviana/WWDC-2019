//
//  EntityManager.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public final class EntityManager {
    
    private let scene: SKScene
    private var entities: Set<GKEntity>
    
    var toRemove = Set<GKEntity>()
    lazy var componentSystems: [GKComponentSystem] = {
        return []
    }()
    
    init(scene: SKScene) {
        self.scene = scene
        entities = Set<GKEntity>()
    }
    
    func add(_ entity: GKEntity) {
        entities.insert(entity)
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }
    
    func add(_ entities: [GKEntity]) {
        entities.forEach { [weak self] entity in
            self?.add(entity)
        }
    }
    
    func remove(_ entity: GKEntity) {
        guard let node = entity.component(ofType: SpriteComponent.self)?.node else {
            return
        }
        
        node.removeFromParent()
        
        entities.remove(entity)
        toRemove.insert(entity)
    }
    
    
    func update(_ deltaTime: CFTimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        toRemove.removeAll()
    }
    
    func getComponents<T: GKComponent>(type: T.Type) -> [T] {
        var components = [T]()
        for entity in entities {
            if let component = entity.component(ofType: T.self) {
                components.append(component)
            }
        }
        return components
    }
    
    func setupSpriteEntities() {
        entities.forEach { entity in
            if let entitySpriteNode = entity.component(ofType: SpriteComponent.self)?.node {
                entitySpriteNode.zPosition = 3
                if !(entity is Ball) {
                    entitySpriteNode.setScale(0.2)
                } else {
                    entitySpriteNode.setScale(0.4)
                }
            }
        }
    }
    
    
    
}
