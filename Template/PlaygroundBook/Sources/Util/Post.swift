//
//  Post.swift
//  Book_Sources
//
//  Created by Thalys Viana on 19/03/19.
//

import SpriteKit

public class Post {
    
    let leftEdge: SKShapeNode
    let rightEdge: SKShapeNode
    
    init(scene: SKScene) {
        leftEdge = SKShapeNode(circleOfRadius: 10)
        let leftEdgeBody = SKPhysicsBody(circleOfRadius: 10)
        leftEdge.physicsBody = leftEdgeBody
        leftEdge.physicsBody?.isDynamic = false
        leftEdge.alpha = 0
        
        rightEdge = SKShapeNode(circleOfRadius: 10)
        let rightEdgeBody = SKPhysicsBody(circleOfRadius: 10)
        rightEdge.physicsBody = rightEdgeBody
        rightEdge.physicsBody?.isDynamic = false
        rightEdge.alpha = 0
        
        leftEdge.zPosition = 3
        rightEdge.zPosition = 3
        
        // post edges
//        leftEdge.fillColor = .red
//        rightEdge.fillColor = .red
        
        scene.addChildren(sequence: [leftEdge, rightEdge])
    }
    
    func setPostPosition(scene: SKScene, fromPoint point: CGPoint) {
        let offset: CGFloat = 16
        
        leftEdge.position.x = scene.frame.midX + gkMinDistance - offset
        leftEdge.position.y = point.y

        rightEdge.position.x = scene.frame.midX + gkMaxDistance + offset
        rightEdge.position.y = point.y
    }
    
}
