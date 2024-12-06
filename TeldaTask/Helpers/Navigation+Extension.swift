//
//  Navigation+Extension.swift
//  Helpers
//
//  Created by Sharaf on 6/21/24.
//

import Foundation
import UIKit

internal final class AppCoordinator {
    
    // MARK: - Properties
    
    private(set) var window: UIWindow
    
    var rootViewController: UIViewController? {
        window.rootViewController
    }
    
    // MARK: - init
    
    init(_ window: UIWindow? = nil) {
        self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
    }
    
    // MARK: - Methods
    
    func setRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Actions
    
    @objc func endEditing() {
        window.endEditing(true)
    }
}
