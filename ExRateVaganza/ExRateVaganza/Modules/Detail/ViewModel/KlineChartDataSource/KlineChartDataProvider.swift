//
//  KlineChartDataProvider.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation

protocol KlineChartDataProvider {
    var x: [Int] { get }
    var y: [Double] { get }
}
