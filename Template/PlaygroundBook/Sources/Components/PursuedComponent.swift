//
//  PursuedComponent.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit
import GameplayKit

class PursuedComponent: MoveComponent  {
    
    override init(maxSpeed: Float, maxAcceleration: Float, radius: Float) {
        super.init(maxSpeed: maxSpeed, maxAcceleration: maxAcceleration, radius: radius)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
}
