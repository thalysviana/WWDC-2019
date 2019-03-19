//
//  NaiveDefenseComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit
import GameplayKit

public class NaiveDefenseComponent: MoveComponent {
    
    let offset: CGFloat = 150
    
    override init(maxSpeed: Float, maxAcceleration: Float, radius: Float) {
        super.init(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: radius)
    }
    
    override public func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
        if behavior == nil {
            guard let spriteNode = entity?.component(ofType: SpriteComponent.self)?.node else {
                fatalError("Agent has no SpriteComponent.")
            }
            let startPoint = vector_float2(point: CGPoint(x: spriteNode.position.x - offset, y: spriteNode.position.y))
            let endPoint = vector_float2(point: CGPoint(x: spriteNode.position.x + offset, y: spriteNode.position.y))
            
            let path = GKPath(points: [startPoint, endPoint], radius: 0, cyclical: false)
            
            let goal = GKGoal(toStayOn: path, maxPredictionTime: 50)
            behavior = GKBehavior(goal: goal, weight: 1.0)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
