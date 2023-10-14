//
//  DetailViewModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

final class DetailViewModel: DetailViewModelInput {
    
    // MARK: Properties
    private let loadingManager: Loading
    private let alertManager: AlertShowable
    private let pairAPI: PairFetchable
    private let klineDataProvider: KlineDataRequestProvider
    
    weak var output: DetailViewModelOutput?
    
    // MARK: Init
    init(loadingManager: Loading, alertManager: AlertShowable, pairAPI: PairFetchable, klineDataProvider: KlineDataRequestProvider) {
        self.loadingManager = loadingManager
        self.alertManager = alertManager
        self.pairAPI = pairAPI
        self.klineDataProvider = klineDataProvider
    }
    
    func viewDidLoad() {
        getKlineData(provider: klineDataProvider)
        generateNavigationTitle(with: klineDataProvider.pairNormalized)
    }
}

// MARK: - Helpers
private extension DetailViewModel {
    func generateNavigationTitle(with pairNormalized: String) {
        let title = "\(pairNormalized.formattedPairNormalized) Chart"
        output?.detail(self, didUpdateNavigationTitle: title)
    }
    
    func getKlineData(provider: KlineDataRequestProvider) {
        let request = GetKlineDataRequestModel(
            from: provider.from,
            to: provider.to,
            resolution: provider.resolution,
            symbol: provider.symbol
        )
        
        pairAPI.fetchKlineData(request: request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                let chartDataSource = KlineChartDataSource(
                    x: response.time.map({ Int($0) }),
                    y: response.close
                )
                
                DispatchQueue.main.async {
                    self.output?.detail(self, didFetchKlineChartData: chartDataSource)
                }
                
            case .failure(let error):
                alertManager.showAlert(with: error)
            }
        }
    }
}
