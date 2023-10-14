//
//  AlertManager.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import Foundation
import UIKit

// MARK: - AlertShowable
protocol AlertShowable {
    var controller: UIViewController? { get set }
    func showAlert(with error: NetworkError)
}

// MARK: - AlertManager
final class AlertManager: AlertShowable {
    
    // MARK: Properties
    static let shared: AlertShowable = AlertManager.init()
    
    weak var controller: UIViewController?
    
    // MARK: Init
    private init() { }
    
    func showAlert(with error: NetworkError) {
        guard let controller = controller else { return }
        
        let alert = UIAlertController(title: "", message: error.description, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
        }))

        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
