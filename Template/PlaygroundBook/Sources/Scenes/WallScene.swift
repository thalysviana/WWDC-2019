//
//  WallScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 18/03/19.
//

import UIKit
import SpriteKit
import GameplayKit

public class WallScene: SKScene {
    
    private var entityManager: EntityManager!
    private var player: Player!
    private var ball: Ball!
    private var goalkeeper: Goalkeeper!
    private var containerNode: SKSpriteNode!
    private var post: Post!
    private var goalLine: SKShapeNode!
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    private let label = SKLabelNode()
    
    private var numberOfDefenders = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        physicsWorld.contactDelegate = self
        
        setupEntities()
        setupNodes()
        setupMasks()
        
        
//        naiveDefense(goalkeeper: goalkeeper)
    }
    
    override public func didMove(to view: SKView) {
        sceneBackground.zPosition = 1
        sceneBackground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        sceneBackground.size = self.frame.size
        
        addChild(sceneBackground)
    }
    
//    public override func didChangeSize(_ oldSize: CGSize) {
//        super.didChangeSize(oldSize)
//        sceneBackground.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        sceneBackground.size = self.size
//    }

    private func setupEntities() {
        entityManager = EntityManager(scene: self)
        player = Player()
        ball = Ball(textureName: "ball")
        goalkeeper = Goalkeeper(seek: ball)
        post = Post(scene: self, goalkeeper: goalkeeper)
        
        entityManager.add([player, ball, goalkeeper])
    }
    
    private func setupNodes() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        physicsBody = borderBody
        
        containerNode = SKSpriteNode()
        
        let playerNode = player.spriteComponent.node
        let ballNode = ball.spriteComponent.node
        let goalkeeperNode = goalkeeper.spriteComponent.node
        
        addChildren(sequence: [playerNode, ballNode, goalkeeperNode, containerNode])
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        goalkeeperNode.position = CGPoint(x: frame.midX, y: frame.maxY - 160)
        
        ballNode.position = playerNode.position
        ballNode.isHidden = true
        
        setupWall()
        post.setPostEdgesPositions(scene: self, goalkeeper: goalkeeper)
        setupGoalLine()
    }
    
    private func setupMasks() {
        let ballBody = ball.physicsComponent.body
        let goalkeeperBody = goalkeeper.physicsComponent.body
        
        goalkeeperBody.categoryBitMask = CategoryMask.goalkeeper
        ballBody.categoryBitMask = CategoryMask.ball
        goalLine.physicsBody?.categoryBitMask = CategoryMask.goalLine
        physicsBody?.categoryBitMask = CategoryMask.fieldEdge
        
        ballBody.collisionBitMask = (CategoryMask.goalkeeper | CategoryMask.fieldEdge | ~CategoryMask.goalLine)
        ballBody.contactTestBitMask = (CategoryMask.goalkeeper | CategoryMask.fieldEdge | CategoryMask.goalLine)
    }
    
    private func setupGoalLine() {
        let linePath = CGMutablePath()
        let startPoint = CGPoint(x: post.leftEdge.position.x, y: post.leftEdge.position.y + 10)
        let endPoint = CGPoint(x: post.rightEdge.position.x, y: post.rightEdge.position.y + 10)
        
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        goalLine = SKShapeNode(path: linePath)
        goalLine.physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        goalLine.physicsBody?.isDynamic = false
        goalLine.path = linePath
//        goalLine.fillColor = .clear
//        goalLine.strokeColor = .red
//        goalLine.lineCap = .round
//        goalLine.zPosition = 3
        
        self.addChild(goalLine)
    }
    
    private func setupWall() {
        numberOfDefenders = getRandomNumberOfWallPlayers(inRange: minNumberDefenders...maxNumberDefenders)
        let wallPoint = generateWallPosition(inSceneFrame: frame)
        createWallDefenders(atPoint: wallPoint, numOfplayers: numberOfDefenders)
        entityManager.setupSpriteEntities()
    }
    
    private func createWallDefenders(atPoint point: CGPoint, numOfplayers: Int) {
        let numberOfPlayers = numOfplayers > maxNumberDefenders || numOfplayers < minNumberDefenders ? maxNumberDefenders : numOfplayers
        var defenders  = [Defender]()
        
        for _ in 0..<numberOfPlayers {
            let newPlayer = Defender()
            defenders.append(newPlayer)
        }
        
        setupWallNodes(atPoint: point, defenders: defenders)
    }
    
    private func setupWallNodes(atPoint point: CGPoint, defenders: [Defender]) {
        entityManager.add(defenders)
        
        var lastPosition: CGFloat = 0
        let distanceOffset: CGFloat = 50
        
        for i in 0..<defenders.count {
            let defenderNode = defenders[i].spriteComponent.node
            containerNode.addChild(defenderNode)
            defenderNode.position.x = CGFloat(lastPosition)
            lastPosition += distanceOffset
        }
        containerNode.position = point
    }
    
    private func recreateWall() {
        containerNode.removeAllChildren()
        
        setupWall()
    }
    
    private func spawnBall() {
        let ballNode = ball.spriteComponent.node
        let ballBody = ball.physicsComponent.body
        let playerNode = player.spriteComponent.node
        addChild(ballNode)
        
        ballBody.linearDamping = 0
        ballNode.position = playerNode.position
        ballNode.isHidden = true
        
        recreateWall()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        touchLocation = pos
        touchTime = CACurrentMediaTime()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        shootBall(inScene: self, atPoint: pos, touchTime: touchTime, touchLocation: touchLocation, player: player, ball: ball) { [unowned self] in
            smartDefense(inScene: self, baseLocation: self.player.spriteComponent.node.position, curLocation: pos, prevLocation: self.touchLocation, goalkeeper: self.goalkeeper)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entityManager.update(deltaTime)
    }
    
}

extension WallScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let goalkeeperCollision = CategoryMask.ball | CategoryMask.goalkeeper
        let fieldEdgeCollision = CategoryMask.ball | CategoryMask.fieldEdge
        let goalLineCollision = CategoryMask.ball | CategoryMask.goalLine
        
        if collision == goalkeeperCollision {
            print("Ball + Goalkeeper collision!")
            ballDidCollideWithFieldAndGoalkeeper(stop: true)
        } else if collision == fieldEdgeCollision {
            print("Ball + Field edge collision!")
            ballDidCollideWithFieldAndGoalkeeper(stop: false)
        } else if collision == goalLineCollision {
            print("Ball + Goal line collision!")
            ballDidCollideWithGoalLine()
        }
    }
    
    func ballDidCollideWithFieldAndGoalkeeper(stop: Bool) {
        let ballNode = ball.spriteComponent.node
        let ballBody = ball.physicsComponent.body
        
        ballBody.linearDamping = 0.6
        
        if !stop {
            ballBody.velocity = CGVector(dx: 0, dy: 0)
        }
        
        ballNode.run(SKAction.wait(forDuration: 0.5)) { [weak self] in
            ballNode.removeFromParent()
            self?.spawnBall()
        }
    }
    
    func ballDidCollideWithGoalLine() {
        let ballNode = ball.spriteComponent.node
        let ballBody = ball.physicsComponent.body
        
        ballBody.linearDamping = 1.0
        ballBody.velocity = CGVector(dx: 0, dy: 0)
        
        ballNode.run(SKAction.wait(forDuration: 0.5)) { [weak self] in

            ballNode.removeFromParent()
            self?.spawnBall()
        }
    }
    
}
