//
//  GetKlineDataRequestModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

class GetKlineDataRequestModel: RequestModel {
    
    // MARK: Properties
    private let from: Int
    private let to: Int
    private let resolution: Int
    private let symbol: String
    
    override var path: String {
        Constant.API.klineDataUrl
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?] {
        [
            "from": "\(from)",
            "to": "\(to)",
            "resolution": "\(resolution)",
            "symbol": "\(symbol)"
        ]
    }
    
    // MARK: Init
    init(from: Int, to: Int, resolution: Int, symbol: String) {
        self.from = from
        self.to = to
        self.resolution = resolution
        self.symbol = symbol
    }
}
