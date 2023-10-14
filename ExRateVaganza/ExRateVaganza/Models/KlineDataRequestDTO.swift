//
//  KlineDataRequestDTO.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation

protocol KlineDataRequestProvider {
    var from: Int { get }
    var to: Int { get }
    var resolution: Int { get }
    var symbol: String { get }
    var pairNormalized: String { get }
}

struct KlineDataRequestDTO: KlineDataRequestProvider {
    let from: Int
    let to: Int
    let resolution: Int
    let symbol: String
    let pairNormalized: String
}
