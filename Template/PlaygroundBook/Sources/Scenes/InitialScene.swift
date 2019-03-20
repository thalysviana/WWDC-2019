//
//  GameScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

public class InitialScene: SKScene {
    
    private var entityManager: EntityManager!
    private var player: Player!
    private var ball: Ball!
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .white
        
        setupEntities()
        setupNodes()
    }
    
    override public func didMove(to view: SKView) {
        sceneBackground.zPosition = 1
        sceneBackground.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        addChild(sceneBackground)
    }
    
    private func setupEntities() {
        entityManager = EntityManager(scene: self)
        player = Player(textureName: "character")
        ball = Ball(textureName: "ball")
        
        entityManager.add([player, ball])
        entityManager.setupSpriteEntities()
    }
    
    private func setupNodes() {
        let playerNode = player.spriteComponent.node
        let ballNode = ball.spriteComponent.node
        
        addChildren(sequence: [playerNode, ballNode])
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        
        ball.spriteComponent.node.position = playerNode.position
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
    }
    
}
