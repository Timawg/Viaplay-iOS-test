//
//  NetworkService.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

public enum HTTPRequestMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(method: HTTPRequestMethod, url: URL, cachePolicy: URLRequest.CachePolicy, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    static private let defaultCacheCapacity = 30*1024*1024
    private var session: URLSession
    
    init(configuration: URLSessionConfiguration = .default, cacheCapacity: Int = defaultCacheCapacity) {
        session = URLSession(configuration: configuration)
        URLCache.shared = URLCache(memoryCapacity: cacheCapacity,
                                   diskCapacity: cacheCapacity,
                                   directory: nil)
    }

    func request<T: Decodable>(method: HTTPRequestMethod, url: URL, cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request = URLRequest(url: url, cachePolicy: cachePolicy)
        request.httpMethod = method.rawValue
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.error(error)))
                return
            }
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(model))
        }
        task.resume()
    }
}
