//
//  ResponseModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

class ResponseModel<T: Codable>: Codable {
    let data: T
    let success: Bool
    let message: String?
    let code: Int
    
    init(data: T, success: Bool, message: String?, code: Int) {
        self.data = data
        self.success = success
        self.message = message
        self.code = code
    }
}
