//
//  HomeRouter.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

protocol HomeRouting {
    var controller: UIViewController? { get set }
    
    func navigateToDetail(_ klineDataProvider: KlineDataRequestProvider)
}

final class HomeRouter: HomeRouting {
    
    // MARK: Properties
    weak var controller: UIViewController?
    
    private var navigationController: UINavigationController? {
        controller?.navigationController
    }
    
    func navigateToDetail(_ klineDataProvider: KlineDataRequestProvider) {
        guard let navigationController else { return }
        
        let detailController = DetailBuilder.build(klineDataProvider: klineDataProvider)
        navigationController.show(detailController, sender: controller)
    }
}
