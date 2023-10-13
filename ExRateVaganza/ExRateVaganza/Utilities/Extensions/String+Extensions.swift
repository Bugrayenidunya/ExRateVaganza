//
//  String+Extensions.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

extension String {
    static let empty = ""
    
    var formattedPairNormalized: String {
        self.replacingOccurrences(of: "_", with: "/")
    }
}
