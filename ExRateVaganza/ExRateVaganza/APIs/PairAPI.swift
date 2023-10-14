//
//  PairAPI.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 12.10.2023.
//

import Foundation

protocol PairFetchable {
    typealias PairsResponseHandler = (Result<GetAllPairsResponseModel, NetworkError>) -> Void
    typealias KlineDataResponseHandler = (Result<GetKlineDataResponseModel, NetworkError>) -> Void
    
    func fetchAllPairs(request: RequestModel, completion: @escaping PairsResponseHandler)
    func fetchKlineData(request: RequestModel, completion: @escaping KlineDataResponseHandler)
}

final class PairAPI: PairFetchable {
    
    // MARK: Properties
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    // MARK: Functions
    func fetchAllPairs(request: RequestModel, completion: @escaping PairsResponseHandler) {
        networkManager.request(request: request, completion: completion)
    }
    
    func fetchKlineData(request: RequestModel, completion: @escaping KlineDataResponseHandler) {
        networkManager.request(request: request, completion: completion)
    }
}
