//
//  HomeCollectionViewCellProvider.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

protocol HomePairCollectionViewCellProvider {
    var isFavorited: Bool { get }
    var pairName: String { get }
    var pairNormalized: String { get }
    var last: Double { get }
    var dailyPercent: Double { get }
    var volume: Double { get }
    var numeratorName: String { get }
}
