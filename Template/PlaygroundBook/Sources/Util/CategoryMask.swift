//
//  CategoryMask.swift
//  Book_Sources
//
//  Created by Thalys Viana on 17/03/19.
//

import Foundation

public struct CategoryMask {
    static let ball: UInt32 = 0x1 << 0 // 0
    static let goalkeeper: UInt32 = 0x1 << 1 // 1
    static let fieldEdge: UInt32 = 0x1 << 2 // 2
}
