//
//  NetworkServiceMock.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import Foundation
import Viaplay_test

final class NetworkServiceMock: NetworkServiceProtocol {
    
    private var result: Result<Decodable, NetworkError>!
    
    func set(result: Result<Decodable, NetworkError>) {
        self.result = result
    }
    
    func request<T>(method: HTTPRequestMethod, url: URL, cachePolicy: URLRequest.CachePolicy, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        switch result {
        case .success(let model):
            completion(.success(model as! T))
        case .failure(let error):
            completion(.failure(error))
        case .none:
            fatalError()
        }
    }
}
