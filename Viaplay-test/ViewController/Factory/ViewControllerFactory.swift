//
//  ViewControllerFactory.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-16.
//

import Foundation
import UIKit

enum ViewControllerType {
    case section(ViewModelProtocol)
    case detail(ViewModelProtocol)
}

protocol ViewControllerFactoryProtocol {
    static func createViewController(type: ViewControllerType) -> (UIViewController & ViewControllerProtocol)
}

final class ViewControllerFactory: ViewControllerFactoryProtocol {
    
    static func createViewController(type: ViewControllerType) -> (UIViewController & ViewControllerProtocol) {
        switch type {
        case .section(let viewModel):
            return SectionsTableViewController(viewModel: viewModel)
        case .detail(let viewModel):
            return DetailViewController(viewModel: viewModel)
        }
    }
}
