//
//  AppDelegate.swift
//  TeldaTask
//
//  Created by Sharaf on 12/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

        //MARK: - Properties
        var window: UIWindow?
        private(set) lazy var coordinator = AppCoordinator()
            
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
                let popularMoviesViewController = PopularMoviesViewController(viewModel: PopularMoviesViewModel())
                let uiNavigationController = UINavigationController(rootViewController: popularMoviesViewController)
                coordinator.setRoot(uiNavigationController)
                return true
            }
    }
