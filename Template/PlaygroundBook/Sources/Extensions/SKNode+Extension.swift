//
//  SKNode+Extension.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import SpriteKit

extension SKNode {
    func addChildren(sequence: [SKNode]) {
        sequence.forEach { node in
            addChild(node)
        }
    }
}
