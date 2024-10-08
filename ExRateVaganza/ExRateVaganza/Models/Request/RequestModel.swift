//
//  RequestModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

class RequestModel {
    
    // MARK: Properties
    
    /// Path of your request enpoint
    var path: String {
        ""
    }

    /// Parameters that you want to add to your request url
    var parameters: [String: Any?] {
        [:]
    }

    /// Headers that you want to define before making a network request
    var headers: [String: String] {
        [:]
    }

    /// Request method of your network request
    var method: RequestMethod {
        body.isEmpty ? .get : .post
    }

    /// Add whatever `key:value` pair that you want to send via network request
    var body: [String: Any?] {
        [
            "Content-Type": "application/json; charset=UTF-8",
            "Accept": "*/*"
        ]
    }
    
    func generateRequest() -> URLRequest? {
        guard let url = generateUrl(with: generateQueryItems()) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return appendBodyIfNeeded(to: request)
    }
}

// MARK: - Helpers
private extension RequestModel {
    func generateUrl(with queryItems: [URLQueryItem]) -> URL? {
        let endpoint = path
        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func generateQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        parameters.forEach { parameter in
            let value = parameter.value as! String
            queryItems.append(.init(name: parameter.key, value: value))
        }
        
        return queryItems
    }
    
    func appendBodyIfNeeded(to request: URLRequest) -> URLRequest {
        var mutableRequest = request
        var jsonText: String = .empty
        
        guard method == RequestMethod.post else { return request }
        
        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []),
           let encodedJson = String(data: data, encoding: .utf8) {
            jsonText = encodedJson
        }
        
        let postData = jsonText.data(using: .utf8)
        mutableRequest.httpBody = postData
        
        return mutableRequest
    }
}
