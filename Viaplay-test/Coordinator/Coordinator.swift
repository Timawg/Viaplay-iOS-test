//
//  Coordinator.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get }
    init(navigationController: UINavigationController, window: UIWindow?)
    func activate()
    func coordinate(toUrl: URL, withTitle: String)
    func present(errorMessage: String)
}

final class Coordinator: CoordinatorProtocol {
    
    private var window: UIWindow?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func activate() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        navigationController.viewControllers.first?.viewDidLoad()
    }
    
    func coordinate(toUrl url: URL, withTitle title: String) {
        let viewModel = SectionsViewModel(title: title, url: url)
        viewModel.coordinator = self
        let viewController = SectionsTableViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        navigationController.present(alert, animated: true, completion: nil)
    }    
}
