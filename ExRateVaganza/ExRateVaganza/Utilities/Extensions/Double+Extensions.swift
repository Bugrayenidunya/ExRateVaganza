//
//  Double+Extensions.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

extension Double {
    /// Get the value as String and format of '%.2f'
    var stringValueWithTwoFloatingPoints: String {
        String(format: "%.2f", self)
    }
    
    /// Get the value as String and format of '%.3f'
    var stringValueWithThreeFloatingPoints: String {
        String(format: "%.3f", self)
    }
}
