//
//  WallScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 18/03/19.
//

import UIKit
import SpriteKit
import GameplayKit

public class GoalkeeperScenePage1: SKScene {
    
    private var entityManager: EntityManager!
    private var player: Player!
    private var ball: Ball!
    private var goalkeeper: Goalkeeper!
    private var post: Post!
    private var goalLine: SKShapeNode!
    private var goalAndAreaNode: SKSpriteNode!
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        configScene()
        naiveDefense(goalkeeper: goalkeeper)
    }
    
    private func configScene() {
        physicsWorld.contactDelegate = self
        
        setupGoalArea()
        setupEntities()
        setupNodes()
        setupMasks()
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
        ball = Ball()
        goalkeeper = Goalkeeper(seek: ball)
        post = Post(scene: self)
        
        entityManager.add([player, ball, goalkeeper])
    }
    
    private func addGoalkeeper() {
        
    }
    
    private func setupNodes() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        physicsBody = borderBody
        
        let playerNode = player.spriteComponent.node
        let ballNode = ball.spriteComponent.node
        let goalkeeperNode = goalkeeper.spriteComponent.node
        
        addChildren(sequence: [playerNode, ballNode, goalkeeperNode])
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        goalkeeperNode.position = CGPoint(x: frame.midX, y: goalAndAreaNode.position.y + 90)
        
        ballNode.position = playerNode.position
        ballNode.isHidden = true
        
        post.setPostPosition(scene: self, fromPoint: CGPoint(x: frame.midX, y: goalAndAreaNode.position.y + 90))
        
        entityManager.setupSpriteEntities()
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
    
    private func setupGoalArea() {
        goalAndAreaNode = SKSpriteNode(imageNamed: "goal&Area")
        addChild(goalAndAreaNode)
        goalAndAreaNode.zPosition = 2
        goalAndAreaNode.setScale(0.6)
        goalAndAreaNode.position = CGPoint(x: frame.midX, y: frame.maxY - 200)
    }
    
    private func spawnBall() {
        let ballNode = ball.spriteComponent.node
        let ballBody = ball.physicsComponent.body
        let playerNode = player.spriteComponent.node
        addChild(ballNode)
        
        ballBody.linearDamping = 0
        ballNode.position = playerNode.position
        ballNode.isHidden = true
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
        shootBall(inScene: self, atPoint: pos, touchTime: touchTime, touchLocation: touchLocation, player: player, ball: ball, completion: nil)
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

extension GoalkeeperScenePage1: SKPhysicsContactDelegate {
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
