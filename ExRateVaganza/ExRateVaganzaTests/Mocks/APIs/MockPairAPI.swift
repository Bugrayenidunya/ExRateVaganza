//
//  MockPairAPI.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockPairAPI: PairFetchable {
    
    // MARK: Properties
    var fetchAllPairsCalled = false
    var fetchKlineDataCalled = false
    var mockFetchAllPairsResponse: Result<GetAllPairsResponseModel, NetworkError>?
    var mockFetchKlineDataResponse: Result<GetKlineDataResponseModel, NetworkError>?

    // MARK: Functions
    func fetchAllPairs(request: RequestModel, completion: @escaping PairsResponseHandler) {
        fetchAllPairsCalled = true
        if let mockResponse = mockFetchAllPairsResponse {
            completion(mockResponse)
        }
    }

    func fetchKlineData(request: RequestModel, completion: @escaping KlineDataResponseHandler) {
        fetchKlineDataCalled = true
        if let mockResponse = mockFetchKlineDataResponse {
            completion(mockResponse)
        }
    }
}
