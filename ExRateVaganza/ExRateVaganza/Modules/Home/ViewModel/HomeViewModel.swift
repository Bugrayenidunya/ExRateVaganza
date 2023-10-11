//
//  HomeViewModel.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation

protocol HomeViewModelInput {
    var output: HomeViewModelOutput? { get set }
}

protocol HomeViewModelOutput: AnyObject {
    
}

final class HomeViewModel: HomeViewModelInput {
    
    // MARK: Properties
    private let router: HomeRouting
    private let loadingManager: Loading
    private let alertManager: AlertShowable
    private let networkManager: Networking
    
    weak var output: HomeViewModelOutput?
    
    // MARK: Init
    init(router: HomeRouting, loadingManager: Loading, alertManager: AlertShowable, networkManager: Networking) {
        self.router = router
        self.loadingManager = loadingManager
        self.alertManager = alertManager
        self.networkManager = networkManager
    }
}
