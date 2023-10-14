//
//  GetKlineDataResponseModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

class GetKlineDataResponseModel: Codable {
    let close: [Double]
    let time: [TimeInterval]
    
    enum CodingKeys: String, CodingKey {
        case close = "c"
        case time = "t"
    }
}
