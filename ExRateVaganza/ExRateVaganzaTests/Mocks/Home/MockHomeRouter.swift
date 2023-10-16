//
//  MockHomeRouter.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import UIKit
@testable import ExRateVaganza

class MockHomeRouting: HomeRouting {
    
    // MARK: Properties
    var controller: UIViewController?
    var navigateToDetailCalled = false
    var mockKlineDataProvider: KlineDataRequestProvider?
    
    // MARK: Functions
    func navigateToDetail(_ klineDataProvider: KlineDataRequestProvider) {
        navigateToDetailCalled = true
        mockKlineDataProvider = klineDataProvider
    }
}
