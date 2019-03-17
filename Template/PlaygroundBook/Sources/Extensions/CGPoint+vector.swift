//
//  CGPoint+vector.swift
//  Book_Sources
//
//  Created by Thalys Viana on 16/03/19.
//

import SpriteKit

extension CGPoint {
    init(vector: vector_float2) {
        let x = CGFloat(vector.x)
        let y = CGFloat(vector.y)
        self.init(x: x, y: y)
    }
}

extension CGVector {
    init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }
}

extension vector_float2 {
    init(point: CGPoint) {
        let x = Float(point.x)
        let y = Float(point.y)
        self.init(x: x, y: y)
    }
}
