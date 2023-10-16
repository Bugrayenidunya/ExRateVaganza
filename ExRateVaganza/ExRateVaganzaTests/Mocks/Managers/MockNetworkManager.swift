//
//  MockNetworkManager.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockNetworkManager: Networking {
    
    // MARK: Properties
    var requestCalled = false
    var lastRequestModel: RequestModel?
    var mockResponse: Result<Codable, NetworkError>?

    // MARK: Functions
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<T, NetworkError>) -> Void) {
        requestCalled = true
        lastRequestModel = request
        
        if let mockResponse = mockResponse as? Result<T, NetworkError> {
            completion(mockResponse)
        }
    }
}
