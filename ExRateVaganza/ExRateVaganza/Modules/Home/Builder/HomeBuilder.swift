//
//  HomeBuilder.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

final class HomeBuilder {
    class func build() -> HomeController {
        let networkManager = NetworkManager(session: .shared)
        var alertManager = AlertManager.shared
        let loadingManager = LoadingManager.shared
        let pairAPI = PairAPI(networkManager: networkManager)
        let userDefaultsManager = UserDefaultsManager.shared
        let router = HomeRouter()
        
        let viewModel = HomeViewModel(
            router: router,
            loadingManager: loadingManager,
            alertManager: alertManager,
            pairAPI: pairAPI,
            userDefaultsManager: userDefaultsManager,
            requestModel: GetAllPairsRequestModel()
        )
        
        let controller = HomeController(viewModel: viewModel)
        
        viewModel.output = controller
        router.controller = controller
        alertManager.controller = controller
        
        return controller
    }
}
