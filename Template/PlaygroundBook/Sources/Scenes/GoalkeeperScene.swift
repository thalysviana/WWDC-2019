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
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        setupEntities()
        setupNodes()
    }
    
    private func setupEntities() {
        entityManager = EntityManager(scene: self)
        player = Player(textureName: "character")
        ball = Ball(textureName: "ball")
        goalKeeper = Goalkeeper(textureName: "enemy")
        
        entityManager.add([player, ball, goalKeeper])
    }
    
    private func setupNodes() {
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        
        physicsBody = borderBody
        
        let playerNode = player.spriteComponent.node
        let ballNode = ball.spriteComponent.node
        let goalkeeperNode = goalKeeper.spriteComponent.node
        
        addChildren(sequence: [playerNode, ballNode, goalkeeperNode])
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        goalkeeperNode.position = CGPoint(x: frame.midX, y: frame.maxY - 50)
        
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
    }
    
}
