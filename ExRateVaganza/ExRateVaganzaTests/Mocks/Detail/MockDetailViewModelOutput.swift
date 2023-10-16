//
//  MockDetailViewModelOutput.swift
//  ExRateVaganzaTests
//
//  Created by Enes Buğra Yenidünya on 16.10.2023.
//

import Foundation
@testable import ExRateVaganza

class MockDetailViewModelOutput: DetailViewModelOutput {
    
    // MARK: Properties
    var detailViewModelDidUpdateNavigationTitleCalled = false
    var lastUpdatedNavigationTitle: String?
    var detailViewModelDidFetchKlineChartDataCalled = false
    var lastFetchedKlineChartData: KlineChartDataSource?
    var showAlertCalled = false
    var lastShownError: NetworkError?

    // MARK: Functions
    func detail(_ viewModel: DetailViewModelInput, didUpdateNavigationTitle title: String) {
        detailViewModelDidUpdateNavigationTitleCalled = true
        lastUpdatedNavigationTitle = title
    }
    
    func detail(_ viewModel: ExRateVaganza.DetailViewModelInput, didFetchKlineChartData provider: ExRateVaganza.KlineChartDataProvider) {
        detailViewModelDidFetchKlineChartDataCalled = true
        lastFetchedKlineChartData = KlineChartDataSource(x: provider.x, y: provider.y)
    }
    
    func showAlert(with error: ExRateVaganza.NetworkError) {
        showAlertCalled = true
        lastShownError = error
    }
}
