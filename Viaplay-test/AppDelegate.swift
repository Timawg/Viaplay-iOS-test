//
//  AppDelegate.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: Coordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        var viewModel = ViewModelFactory.createViewModel(type: .section(nil, nil))
        let sectionsViewController = ViewControllerFactory.createViewController(type: .section(viewModel))
        let navigationController = UINavigationController(rootViewController: sectionsViewController)
        coordinator = Coordinator(navigationController: navigationController, window: window)
        coordinator?.setup()
        viewModel.coordinator = coordinator
        return true
    }
}

