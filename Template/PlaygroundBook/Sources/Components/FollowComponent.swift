////
////  FollowComponent.swift
////  Book_Sources
////
////  Created by Thalys Viana on 17/03/19.
////
//
//import SpriteKit
//import GameplayKit
//
//class FollowComponent: MoveComponent {
//    
//    let entityManager: EntityManager
//    let followBehavior: FollowBehavior
//    
//    override init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
//        self.entityManager = entityManager
//        followBehavior = FollowBehavior(targetSpeed: maxSpeed)
//        super.init(maxSpeed: maxSpeed / 2, maxAcceleration: maxAcceleration, radius: radius, entityManager: entityManager)
//        self.behavior = followBehavior
//    }
//    
//    override func update(deltaTime seconds: TimeInterval) {
//        super.update(deltaTime: seconds)
//        guard let pursuedAgent = self.entityManager.getComponents(type: PursueAgentComponent.self).first else {
//            fatalError("This is no Pursued Agent in the Entity Manager")
//        }
//        
//        guard let pursuedAgentSprite = pursuedAgent.entity?.component(ofType: SpriteComponent.self) else {
//            fatalError("The agent entity has no sprite component")
//        }
//        
//        let distance = simd.distance(pursuedAgent.position, self.position)
//        
//        let radius = Float(pursuedAgentSprite.node.frame.width * 3)
//        
//        if distance > 0 && distance < radius {
//            //            print("activated at distance:", distance)
//            followBehavior.start(with: pursuedAgent)
//        } else {
//            followBehavior.stop()
//        }
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented.")
//    }
//    
//}
