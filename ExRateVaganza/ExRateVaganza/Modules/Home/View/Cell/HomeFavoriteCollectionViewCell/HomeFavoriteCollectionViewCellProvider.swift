//
//  HomeFavoriteCollectionViewCellProvider.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

protocol HomeFavoriteCollectionViewCellProvider {
    var pairName: String { get }
    var last: Double { get }
    var dailyPercent: Double { get }
    var pairNormalized: String { get }
}
