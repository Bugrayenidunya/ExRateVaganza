//
//  MockAlertManager.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import UIKit
@testable import ExRateVaganza

class MockAlertManager: AlertShowable {
    
    // MARK: Properties
    var controller: UIViewController?
    var showAlertCalled = false
    var lastShownError: NetworkError?

    // MARK: Functions
    func showAlert(with error: NetworkError) {
        showAlertCalled = true
        lastShownError = error
    }
}
