//
//  GameScene.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit
import GameplayKit

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi

public class InitialScene: SKScene {
    
    private var entityManager: EntityManager!
    private var player: Player!
    private var ball: Ball!
    
    private let initialPosition: CGPoint = .zero
    
    private var touchLocation = CGPoint.zero
    private var touchTime: CFTimeInterval = 0
    private let ballRadius: CGFloat = 20
    private let ballSpeed: CGFloat = 600
    
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
        
        entityManager.add([player, ball])
    }
    
    private func setupNodes() {
        addChild(player.spriteComponent.node)
        addChild(ball.spriteComponent.node)
        
        player.spriteComponent.node.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        
        ball.spriteComponent.node.position = player.spriteComponent.node.position
        ball.spriteComponent.node.isHidden = true
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
        let touchTimeThreshold: CFTimeInterval = 0.3
        let touchDistanceThreshold: CGFloat = 4
        
        guard CACurrentMediaTime() - touchTime < touchTimeThreshold,
            ball.spriteComponent.node.isHidden else { return }
        
        let location = pos
        let swipe = CGVector(dx: location.x - touchLocation.x, dy: location.y - touchLocation.y)
        let swipeLength = sqrt(swipe.dx * swipe.dx + swipe.dy * swipe.dy)
        
        guard swipeLength > touchDistanceThreshold else { return }
        
        let angle = atan2(swipe.dy, swipe.dx)
        ball.spriteComponent.node.zRotation = angle - 90 * degreesToRadians
        ball.spriteComponent.node.position = player.spriteComponent.node.position
        ball.spriteComponent.node.isHidden = false
        
        //calculate vertical intersection point
        var destination1 = CGPoint.zero
        if swipe.dy > 0 {
            destination1.y = size.height + ballRadius // top of screen
        } else {
            destination1.y = -ballRadius // bottom of screen
        }
        destination1.x = player.spriteComponent.node.position.x +
            ((destination1.y - player.spriteComponent.node.position.y) / swipe.dy * swipe.dx)
        
        //calculate horizontal intersection point
        var destination2 = CGPoint.zero
        if swipe.dx > 0 {
            destination2.x = size.width + ballRadius // right of screen
        } else {
            destination2.x = -ballRadius // left of screen
        }
        destination2.y = player.spriteComponent.node.position.y +
            ((destination2.x - player.spriteComponent.node.position.x) / swipe.dx * swipe.dy)
        
        // find out which is nearer
        var destination = destination2
        if abs(destination1.x) < abs(destination2.x) || abs(destination1.y) < abs(destination2.y) {
            destination = destination1
        }
        
        let distance = sqrt(pow(destination.x - player.spriteComponent.node.position.x, 2) +
            pow(destination.y - player.spriteComponent.node.position.y, 2))
        
        // run the sequence of actions for the firing
        let duration = TimeInterval(distance / ballSpeed)
        let ballMoveAction = SKAction.move(to: destination, duration: duration)
        ball.spriteComponent.node.run(ballMoveAction) {
            self.ball.spriteComponent.node.isHidden = true
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
    }
    
}
