//
//  ViewModelFactory.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-16.
//

import Foundation

enum ViewModelType {
    case section(String?, URL?)
    case detail(String, URL?)
}

protocol ViewModelFactoryProtocol {
    static func createViewModel(type: ViewModelType) -> ViewModelProtocol
}

final class ViewModelFactory: ViewModelFactoryProtocol {
    
    static func createViewModel(type: ViewModelType) -> ViewModelProtocol {
        switch type {
        case .section(let title, let url):
            if let title = title {
                return SectionsViewModel(title: title, url: url)
            } else {
                return SectionsViewModel(url: url)
            }
        case .detail(let title, let url):
            return DetailViewModel(title: title, url: url)
        }
    }
}
