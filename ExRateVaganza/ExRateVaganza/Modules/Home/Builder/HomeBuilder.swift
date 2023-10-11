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
        let alertManager = AlertManager.shared
        let loadingManager = LoadingManager.shared
        let router = HomeRouter()
        let viewModel = HomeViewModel(router: router, loadingManager: loadingManager, alertManager: alertManager, networkManager: networkManager)
        let controller = HomeController(viewModel: viewModel)
        
        return controller
    }
}
