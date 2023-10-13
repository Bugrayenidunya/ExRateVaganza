//
//  Item.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

enum Item: Hashable {
    case favorites(HomeFavoriteCollectionViewCellProvider)
    case pairs(HomePairCollectionViewCellProvider)
    
    var rawValue: Int {
        switch self {
        case .favorites:
            return 0
        case .pairs:
            return 1
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
        
        switch self {
        case .favorites(let provider):
            hasher.combine(provider.pairName)
        case .pairs(let provider):
            hasher.combine(provider.pairName)
            hasher.combine(provider.isFavorited)
        }
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        if lhs.rawValue != rhs.rawValue {
            return false
        }
        
        switch (lhs, rhs) {
        case (.favorites(let leftProvider), .favorites(let rightProvider)):
            return leftProvider.pairName == rightProvider.pairName
        case (.pairs(let leftProvider), .pairs(let rightProvider)):
            return leftProvider.pairName == rightProvider.pairName && leftProvider.isFavorited == rightProvider.isFavorited
        default:
            return false
        }
    }
}
