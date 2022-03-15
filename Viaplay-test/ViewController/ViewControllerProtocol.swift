//
//  ViewControllerProtocol.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

protocol ViewControllerProtocol {
    var _viewModel: ViewModelProtocol { get set }
    init(viewModel: ViewModelProtocol)
}
