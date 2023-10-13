//
//  HomePairCollectionViewCellDTO.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

struct HomePairCollectionViewCellDTO: HomePairCollectionViewCellProvider {
    let isFavorited: Bool
    let pairName: String
    let pairNormalized: String
    let last: Double
    let dailyPercent: Double
    let volume: Double
    let numeratorName: String
}
