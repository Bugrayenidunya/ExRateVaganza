//
//  MockLoadingManager.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockLoadingManager: Loading {
    
    // MARK: Properties
    var showCalled = false
    var hideCalled = false

    // MARK: Functions
    func show() {
        showCalled = true
    }

    func hide() {
        hideCalled = true
    }
}
