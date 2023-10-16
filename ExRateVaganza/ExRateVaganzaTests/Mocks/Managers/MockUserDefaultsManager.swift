//
//  MockUserDefaultsManager.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockUserDefaultsManager: UserDefaultsManagable {
    
    // MARK: Properties
    var setCalled = false
    var getCalled = false
    var lastSetKey: String?
    var lastSetValue: Any?
    var lastGetType: Any.Type?
    var mockResponseValue: Any?

    // MARK: Functions
    func set<T>(value: T, with key: String) where T : Encodable {
        setCalled = true
        lastSetKey = key
        lastSetValue = value
    }

    func get<T>(with key: String, type: T.Type) -> T? where T : Decodable {
        getCalled = true
        lastSetKey = key
        lastGetType = type
        return mockResponseValue as? T
    }
}
