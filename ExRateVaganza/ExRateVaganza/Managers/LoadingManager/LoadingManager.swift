//
//  LoadingManager.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

// MARK: - Loading
protocol Loading {
    func show()
    func hide()
}

// MARK: - LoadingManager
final class LoadingManager: Loading {
    
    // MARK: Properties
    static let shared: Loading = LoadingManager.init()
    private var requestCount: Int = 0
    
    enum Constants {
        static let cornerRadius = 8.0
        static let loadingViewWidth = 74.0
        static let loadingViewHeight = 74.0
        static let activtyIndicatorWidth = 66.0
        static let activtyIndicatorHeight = 66.0
    }
    
    // MARK: Init
    private init() { }
    
    // MARK: Views
    private let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .vaganzaGray.withAlphaComponent(0.3)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        return activityIndicator
    }()
}

// MARK: - Functions
extension LoadingManager {
    /// Show loading view
    func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return }
            self.requestCount += 1
            if self.requestCount == 1 {
                // Show the loading view only when the first request is initiated.
                self.setupLoadingView(on: window)
            }
        }
    }
    
    /// Hide loading view
    func hide() {
        DispatchQueue.main.async {
            self.requestCount -= 1
            if self.requestCount <= 0 {
                // Hide the loading view when the last request has completed.
                self.loadingView.removeFromSuperview()
                UIApplication.shared.keyWindow?.isUserInteractionEnabled = true
                self.requestCount = 0
            }
        }
    }
    
    private func setupLoadingView(on window: UIWindow) {
        window.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        window.bringSubviewToFront(loadingView)
        window.isUserInteractionEnabled = false
        
        loadingView.setConstraint(
            centerX: window.centerXAnchor,
            centerY: window.centerYAnchor,
            width: Constants.loadingViewWidth,
            height: Constants.loadingViewHeight
        )
        
        activityIndicator.setConstraint(
            centerX: loadingView.centerXAnchor,
            centerY: loadingView.centerYAnchor,
            width: Constants.activtyIndicatorWidth,
            height: Constants.activtyIndicatorHeight
        )
    }
}
