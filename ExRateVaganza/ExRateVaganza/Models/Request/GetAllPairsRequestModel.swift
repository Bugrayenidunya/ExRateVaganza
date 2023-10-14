//
//  GetAllPairsRequestModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 12.10.2023.
//

import Foundation

class GetAllPairsRequestModel: RequestModel {
    
    // MARK: Properties
    override var method: RequestMethod {
        .get
    }
    
    override var path: String {
        Constant.API.tickerUrl
    }
}
