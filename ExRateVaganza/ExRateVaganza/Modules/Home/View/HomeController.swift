//
//  HomeController.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

final class HomeController: UIViewController {

    // MARK: Properties
    private let viewModel: HomeViewModelInput
    
    // MARK: Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    init(viewModel: HomeViewModelInput) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension HomeController {
    
}
