//
//  MockHomeViewModelOutput.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 15.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockHomeViewModelOutput: HomeViewModelOutput {
    
    // MARK: Properties
    var homeDidCreatedSectionsCalled = false
    var mockSections: [Section]?
    
    // MARK: Functions
    func home(_ viewModel: HomeViewModelInput, didCreatedSections sections: [Section]) {
        homeDidCreatedSectionsCalled = true
        mockSections = sections
    }
}
