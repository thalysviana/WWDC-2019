//
//  Global.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit

// MARK: - Scene parameters
let sceneBackground = SKSpriteNode(imageNamed: "soccer_field")

// MARK: - Auxiliar convertions
let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

// MARK: - Ball parameters
let ballSpeed: CGFloat = 6000

// MARK: - Goalkeeper parameters
let gkTopDistance: CGFloat = -100
let gkMinDistance: CGFloat = -120
let gkMaxDistance: CGFloat = 120

// MARK: = Wall parameters
let maxNumberDefenders = 4
let minNumberDefenders = 2

// MARK: - Scene commom mechanics
func shootBall(inScene scene: SKScene, atPoint pos: CGPoint, touchTime: CFTimeInterval, touchLocation: CGPoint, player: Player, ball: Ball, completion: (() -> Void)?) {
    let playerNode = player.spriteComponent.node
    let ballNode = ball.spriteComponent.node
    
    let touchTimeThreshold: CFTimeInterval = 0.4
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
    completion?()
}

func naiveDefense(goalkeeper: Goalkeeper) {
    let goalkeeperNode = goalkeeper.spriteComponent.node
    
    let initialMovement = SKAction.moveBy(x: gkMaxDistance, y: 0, duration: 1)
    let rightBackMovement = initialMovement.reversed()
    let leftMovement = SKAction.moveBy(x: gkMinDistance, y: 0, duration: 1)
    let leftBackMovement = leftMovement.reversed()
    let sequence = SKAction.sequence([initialMovement, rightBackMovement, leftMovement, leftBackMovement])
    let repeatAction = SKAction.repeatForever(sequence)
    
    goalkeeperNode.run(repeatAction)
}

func smartDefense(inScene scene: SKScene, baseLocation: CGPoint, curLocation: CGPoint, prevLocation: CGPoint, goalkeeper: Goalkeeper) {
    let goalkeeperNode = goalkeeper.spriteComponent.node
    
    let xDelta = curLocation.x - prevLocation.x
//    let yDelta = curLocation.y - prevLocation.y
//    let endPoint = CGPoint(x: xDelta * 10, y: yDelta * 10)
//
//    let point = intersectionOfLine(from: baseLocation, to: endPoint, withLineFrom: CGPoint(x: 0, y: scene.frame.maxY - gkTopDistance), to: CGPoint(x: scene.frame.maxX, y: scene.frame.maxY - gkTopDistance))
//    var distance: CGFloat = point.x - scene.frame.midX
//
//    let xDeltaScenePrevLocation = abs(scene.frame.midX - prevLocation.x)
//    let xDeltaSceneCurLocation = abs(scene.frame.midX - curLocation.x)
//
//    if xDeltaScenePrevLocation <= 10 && xDeltaSceneCurLocation <= 10 {
//        distance = 0
//    } else {
//        if distance < gkMinDistance {
//            distance = gkMinDistance
//        } else if distance > gkMaxDistance {
//            distance = gkMaxDistance
//        }
//    }

    let distance = xDelta
    
    let moveAction = SKAction.moveBy(x: distance, y: 0, duration: 0.5)
    let reverseAction = moveAction.reversed()
    let sequenceAction = SKAction.sequence([moveAction, reverseAction])
    goalkeeperNode.run(sequenceAction)
}

func getRandomNumberOfWallPlayers(inRange range: ClosedRange<Int>) -> Int {
    return Int.random(in: range)
}

func generateWallPosition(inSceneFrame frame: CGRect) -> CGPoint {
    let minXOffset: CGFloat = 160
    let maxXOffset: CGFloat = 10
    let minYOffset: CGFloat = 300
    let maxYOffset: CGFloat = 350
    
    let xRange = Int((frame.midX - minXOffset))...Int((frame.midX + maxXOffset))
    let yRange = Int((frame.maxY - maxYOffset))...Int((frame.maxY - minYOffset))
    
    let xPosition = Int.random(in: xRange)
    let yPosition = Int.random(in: yRange)
    print(xPosition)
    return CGPoint(x: xPosition, y: yPosition)
}

// MARK: - Calculations
func intersectionOfLine(from p1: CGPoint, to p2: CGPoint, withLineFrom p3: CGPoint, to p4: CGPoint) -> CGPoint {
    let d: CGFloat = (p2.x - p1.x)*(p4.y - p3.y) - (p2.y - p1.y)*(p4.x - p3.x)
    if d == 0 {
        print("No intersection")
    }
    let u = ((p3.x - p1.x)*(p4.y - p3.y) - (p3.y - p1.y)*(p4.x - p3.x))/d
    let v = ((p3.x - p1.x)*(p2.y - p1.y) - (p3.y - p1.y)*(p2.x - p1.x))/d
    
    if u < 0 || u > 1 {
        print("No intersection")
    }
    
    if v < 0 || v > 1 {
        print("No intersection")
    }
    let xIntersection = p1.x + u * (p2.x - p1.x)
    let yIntersection = p1.y + u * (p2.y - p1.y)
    
    return CGPoint(x: xIntersection, y: yIntersection)
}

func drawLine(startPoint: CGPoint, endPoint: CGPoint, inScene scene: SKScene, horizontalLine: Bool) {
    var finalPoint = CGPoint(x: endPoint.x * 10, y: endPoint.y * 10)
    
    if horizontalLine {
        finalPoint = endPoint
    }
    
    let path = CGMutablePath()
    path.move(to: startPoint)
    path.addLine(to: finalPoint)
    
    let line = SKShapeNode(path: path)
    line.zPosition = 5
    line.path = path
    line.fillColor = .clear
    line.strokeColor = .red
    line.lineCap = .round
    
    scene.addChild(line)
}

func getBaseVector(atPoint pos: CGPoint, touchLocation: CGPoint) -> CGVector {
    let location = pos
    let xDelta = location.x - touchLocation.x
    let yDelta = location.y - touchLocation.y
    let swipe = CGVector(dx: xDelta, dy: yDelta)
    let swipeLength = sqrt(swipe.dx * swipe.dx + swipe.dy * swipe.dy)
    let base = CGVector(dx: xDelta/swipeLength * ballSpeed, dy: yDelta/swipeLength * ballSpeed)
    return base
}
