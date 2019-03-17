//
//  Global.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit

// MARK: - Auxiliar convertions
let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

// MARK: - Ball parameters
let ballRadius: CGFloat = 20
let ballSpeed: CGFloat = 5000

// MARK: - Scene commom mechanics
func shootBall(inScene scene: SKScene, atPoint pos: CGPoint, touchTime: CFTimeInterval, touchLocation: CGPoint, player: Player, ball: Ball) {
    let playerNode = player.spriteComponent.node
    let ballNode = ball.spriteComponent.node
    
    let touchTimeThreshold: CFTimeInterval = 0.3
    let touchDistanceThreshold: CGFloat = 4
    
    guard CACurrentMediaTime() - touchTime < touchTimeThreshold,
        ballNode.isHidden else { return }
    
    let location = pos
    let xDelta = location.x - touchLocation.x
    let yDelta = location.y - touchLocation.y
    let swipe = CGVector(dx: xDelta, dy: yDelta)
    let swipeLength = sqrt(swipe.dx * swipe.dx + swipe.dy * swipe.dy)
    let base = CGVector(dx: xDelta/swipeLength * ballSpeed, dy: yDelta/swipeLength * ballSpeed)
    
    guard swipeLength > touchDistanceThreshold else { return }
    
    let angle = atan2(swipe.dy, swipe.dx)
    ballNode.zRotation = angle - 90 * degreesToRadians
    ballNode.position = playerNode.position
    ballNode.isHidden = false

    ball.physicsComponent.body.applyForce(base)
}
