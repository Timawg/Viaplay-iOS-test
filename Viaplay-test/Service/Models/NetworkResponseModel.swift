//
//  NetworkResponseModel.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

enum NetworkError: Error {
    case error(Error?)
    case decodingError
}

struct NetworkResponseModel: Decodable {
    let title: String
    let description: String
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case links = "_links"
    }
}

struct Links: Decodable {
    let viaplaySections: [ViaplaySection]
    
    enum CodingKeys: String, CodingKey {
        case viaplaySections = "viaplay:sections"
    }
}

struct ViaplaySection: Decodable {
    let title: String
    private let href: String
    
    var fixedHref: String {
        return href.replacingOccurrences(of: "{?dtg}", with: "")
    }
}
