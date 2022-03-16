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
    func setup()
    func coordinate(toUrl: URL, withTitle: String)
    func present(errorMessage: String, handler: (() -> Void)?)
}

final class Coordinator: CoordinatorProtocol {

    private var window: UIWindow?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func setup() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        navigationController.viewControllers.first?.loadViewIfNeeded()
    }
    
    func coordinate(toUrl url: URL, withTitle title: String) {
        let viewModel = DetailViewModel(title: title, url: url)
        viewModel.coordinator = self
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(errorMessage: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(.init(title: "Dismiss", style: .cancel, handler: nil))
        if let handler = handler {
            alert.addAction(.init(title: "Retry", style: .default, handler:  { _ in
                handler()
            }))
        }
        navigationController.present(alert, animated: true, completion: nil)
    }    
}
