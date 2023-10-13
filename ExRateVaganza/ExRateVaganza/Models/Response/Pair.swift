//
//  Pair.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 12.10.2023.
//

import Foundation

struct Pair: Codable {
    let pair: String
    let pairNormalized: String
    let last: Double
    let volume: Double
    let dailyPercent: Double
    let numeratorSymbol: String
}
