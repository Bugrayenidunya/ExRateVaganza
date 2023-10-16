//
//  MockKlineDataRequestProvider.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockKlineDataRequestProvider: KlineDataRequestProvider {
    
    // MARK: Properties
    var from: Int
    var to: Int
    var resolution: Int
    var symbol: String
    var pairNormalized: String

    // MARK: Init
    init(from: Int, to: Int, resolution: Int, symbol: String, pairNormalized: String) {
        self.from = from
        self.to = to
        self.resolution = resolution
        self.symbol = symbol
        self.pairNormalized = pairNormalized
    }
}
