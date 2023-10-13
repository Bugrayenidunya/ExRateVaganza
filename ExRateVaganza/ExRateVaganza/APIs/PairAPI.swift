//
//  PairAPI.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 12.10.2023.
//

import Foundation

protocol PairFetchable {
    typealias ResponseHandler = (Result<GetAllPairsResponseModel, NetworkError>) -> Void
    
    func fetchAllPairs(request: RequestModel, completion: @escaping ResponseHandler)
}

final class PairAPI: PairFetchable {
    
    // MARK: Properties
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    // MARK: Functions
    func fetchAllPairs(request: RequestModel, completion: @escaping ResponseHandler) {
        networkManager.request(request: request, completion: completion)
    }
}
