//
//  NetworkManager.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

// MARK: - Networking
protocol Networking {
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<T, NetworkError>) -> Void)
}

// MARK: - NetowrkManager
final class NetworkManager: Networking {
    
    // MARK: Properties
    /// Shared url session
    private let session: URLSession
    
    // MARK: Init
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Use this function to making a network call request
    /// - Parameters:
    ///   - request:  Any model that confirms `RequestModel`
    ///   - completion: Escaping closure
    func request<T: Codable>(request: RequestModel, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let generatedRequest = request.generateRequest() else {
            completion(.failure(.badRequest))
            return
        }
        
        let task = session.dataTask(with: generatedRequest) { data, response, error in
            if error != nil || data == nil { completion(.failure(.unknownError)) }
            
            if let apiEror = self.returnResponseErorIfNeeded(response: response) {
                completion(.failure(apiEror))
            }
            
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.unknownError))
            }
        }
        
        task.resume()
    }
}

// MARK: - Helpers
private extension NetworkManager {
    func returnError(with responseCode: Int) -> NetworkError {
        switch responseCode {
        case 400:
            return .notFound
        case 403:
            return .unknownError
        case 408:
            return .timeOut
        case 500:
            return .serverError
        default:
            return .unknownError
        }
    }
    
    func returnResponseErorIfNeeded(response: URLResponse?) -> NetworkError? {
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            return returnError(with: httpResponse.statusCode)
        }
        
        return nil
    }
}
