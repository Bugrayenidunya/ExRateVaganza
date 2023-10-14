//
//  DetailBuilder.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

final class DetailBuilder {
    static func build(klineDataProvider: KlineDataRequestProvider) -> DetailController {
        let networkManager = NetworkManager(session: .shared)
        var alertManager = AlertManager.shared
        let loadingManager = LoadingManager.shared
        let pairAPI = PairAPI(networkManager: networkManager)
        
        let viewModel = DetailViewModel(loadingManager: loadingManager, alertManager: alertManager, pairAPI: pairAPI, klineDataProvider: klineDataProvider)
        let controller = DetailController(viewModel: viewModel)
        
        alertManager.controller = controller
        viewModel.output = controller
        
        return controller
    }
}
