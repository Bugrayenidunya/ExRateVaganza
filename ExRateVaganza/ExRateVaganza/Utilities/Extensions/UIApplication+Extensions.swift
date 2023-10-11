//
//  UIApplication+Extensions.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

extension UIApplication {
    /// Get optional keyWindow
    var keyWindow: UIWindow? {
        self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
