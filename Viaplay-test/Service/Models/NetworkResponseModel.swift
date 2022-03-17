//
//  NetworkResponseModel.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

public enum NetworkError: Error {
    case error(Error?)
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .error(let error): return error?.localizedDescription ?? "Unknown error"
        case .decodingError: return "Decoding error"
        }
    }
}

public struct NetworkResponseModel: Decodable {
    public let title: String
    public let description: String
    public let links: Links
    
    public init(title: String, description: String, links: Links) {
        self.title = title
        self.description = description
        self.links = links
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case links = "_links"
    }
}

public struct Links: Decodable {
    public let viaplaySections: [ViaplaySection]
    
    public init(viaplaySections: [ViaplaySection]) {
        self.viaplaySections = viaplaySections
    }
    
    enum CodingKeys: String, CodingKey {
        case viaplaySections = "viaplay:sections"
    }
}

public struct ViaplaySection: Decodable {
    public let title: String
    public let href: String
    
    public init(title: String, href: String) {
        self.title = title
        self.href = href
    }
    
    public var fixedHref: String {
        return href.replacingOccurrences(of: "{?dtg}", with: "")
    }
}
