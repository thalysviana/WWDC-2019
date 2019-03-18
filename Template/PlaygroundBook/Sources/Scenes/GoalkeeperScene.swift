//
//  GameScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class GoalkeeperScene: SKScene {
    
    private var entityManager: EntityManager!
    private var player: Player!
    private var ball: Ball!
    private var goalKeeper: Goalkeeper!
    private var containerNode: SKShapeNode!
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    
    private var lastUpdateTimeInterval = TimeInterval(0)
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        physicsWorld.contactDelegate = self
        
        setupEntities()
        setupNodes()
        setupMasks()
    }
    
    private func setupEntities() {
        entityManager = EntityManager(scene: self)
        player = Player(textureName: "character")
        ball = Ball(textureName: "ball")
        goalKeeper = Goalkeeper(textureName: "enemy", seek: ball)
        
        entityManager.add([player, ball, goalKeeper])
    }
    
    private func setupNodes() {
        containerNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: frame.midX/2, y: frame.maxY - 150), size: CGSize(width: 400, height: 64)))
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        physicsBody = borderBody
        
        let playerNode = player.spriteComponent.node
        let ballNode = ball.spriteComponent.node
        let goalkeeperNode = goalKeeper.spriteComponent.node
        
        addChildren(sequence: [playerNode, ballNode, goalkeeperNode])
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        goalkeeperNode.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        
        ballNode.position = playerNode.position
        ballNode.isHidden = true
        
        goalKeeper.addNaiveDefense()
//        goalKeeper.addSmartDefense(withNode: containerNode, inScene: self)
    }
    
    private func setupMasks() {
        let ballBody = ball.physicsComponent.body
        let goalkeeperBody = goalKeeper.physicsComponent.body
        
        goalkeeperBody.categoryBitMask = CategoryMask.goalkeeper
        ballBody.categoryBitMask = CategoryMask.ball
        physicsBody?.categoryBitMask = CategoryMask.fieldEdge
        
        
        goalkeeperBody.collisionBitMask = CategoryMask.container
        ballBody.collisionBitMask = CategoryMask.goalkeeper | CategoryMask.fieldEdge & ~CategoryMask.container
        ballBody.contactTestBitMask = CategoryMask.goalkeeper | CategoryMask.fieldEdge
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
        shootBall(inScene: self, atPoint: pos, touchTime: touchTime, touchLocation: touchLocation, player: player, ball: ball)
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

extension GoalkeeperScene: SKPhysicsContactDelegate {
    public func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let goalkeeperCollision = CategoryMask.ball | CategoryMask.goalkeeper
        let fieldEdge = CategoryMask.ball | CategoryMask.fieldEdge
        
        if collision == goalkeeperCollision {
            print("Ball + Goalkeeper collision!")
            ballDidCollide(withMovement: true)
        } else if collision == fieldEdge {
            print("Ball + Field edge collision!")
            ballDidCollide(withMovement: false)
        }
    }
    
    public func ballDidCollide(withMovement movement: Bool) {
        let ballNode = ball.spriteComponent.node
        let ballBody = ball.physicsComponent.body
        
        ballBody.linearDamping = 0.6
        
        if !movement {
            ballBody.velocity = CGVector(dx: 0, dy: 0)
        }
        
        ballNode.run(SKAction.wait(forDuration: 1)) { [weak self] in
            ballNode.removeFromParent()
            self?.spawnBall()
        }
    }
    
}
