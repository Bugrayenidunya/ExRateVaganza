//
//  UserDefaultsManager.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 13.10.2023.
//

import Foundation

protocol UserDefaultsManagable {
    func set<T: Encodable>(value: T, with key: String)
    func get<T: Decodable>(with key: String, type: T.Type) -> T?
}

final class UserDefaultsManager: UserDefaultsManagable {
    
    // MARK: Properties
    static let shared: UserDefaultsManagable = UserDefaultsManager(userDefaults: .standard)
    private let userDefaults: UserDefaults
    
    // Initialize with the UserDefaults instance
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func set<T>(value: T, with key: String) where T : Encodable {
        userDefaults.setValue(value, forKey: key)
    }
    
    func get<T>(with key: String, type: T.Type) -> T? where T : Decodable {
        userDefaults.value(forKey: key) as? T
    }
}
