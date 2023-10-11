//
//  HomeRouter.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

protocol HomeRouting {
    var controller: UIViewController? { get set }
}

final class HomeRouter: HomeRouting {
    
    // MARK: Properties
    weak var controller: UIViewController?
}
