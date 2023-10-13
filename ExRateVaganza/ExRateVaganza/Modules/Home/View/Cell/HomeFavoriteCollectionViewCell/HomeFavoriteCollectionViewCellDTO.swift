//
//  HomeFavoriteCollectionViewCellDTO.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

struct HomeFavoriteCollectionViewCellDTO: HomeFavoriteCollectionViewCellProvider {
    let pairName: String
    let last: Double
    let dailyPercent: Double
    let pairNormalized: String
}
