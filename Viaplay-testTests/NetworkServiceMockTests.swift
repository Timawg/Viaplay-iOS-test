//
//  Viaplay_testTests.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import XCTest
@testable import Viaplay_test

class NetworkServiceMockTests: XCTestCase {
    
    @Injected(\.networkService) private var networkService: NetworkServiceProtocol
    
    override class func setUp() {
        super.setUp()
        InjectedValues[\.networkService] = NetworkServiceMock()
    }

    func testSuccess() throws {
        
        let exp = expectation(description: "Successful response")
        let responseModel = NetworkResponseModel(title: "Test",
                                                 description: "Testing",
                                                 links: .init(viaplaySections: [.init(title: "Link", href: "www.viaplay.com")]))
        (networkService as? NetworkServiceMock)?.set(result: .success(responseModel))
        networkService.request(method: .GET, url: URL(string: "www.viaplay.com")!, cachePolicy: .returnCacheDataElseLoad) { (result: Result<NetworkResponseModel, NetworkError>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(responseModel.title, model.title)
                XCTAssertEqual(responseModel.description, model.description)
                XCTAssertEqual(responseModel.links.viaplaySections.first?.href, model.links.viaplaySections.first?.href)
                exp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func testNoConnectionError() {
        
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Internet connection appears to be offline"])
        let exp = expectation(description: "Unsuccessful response")
        (networkService as? NetworkServiceMock)?.set(result: .failure(.error(error)))
        networkService.request(method: .GET, url: URL(string: "www.viaplay.com")!, cachePolicy: .returnCacheDataElseLoad) { (result: Result<NetworkResponseModel, NetworkError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Internet connection appears to be offline")
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func testUnknownError() throws {
        
        let exp = expectation(description: "Unsuccessful response")
        (networkService as? NetworkServiceMock)?.set(result: .failure(.error(nil)))
        networkService.request(method: .GET, url: URL(string: "www.viaplay.com")!, cachePolicy: .returnCacheDataElseLoad) { (result: Result<NetworkResponseModel, NetworkError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Unknown error")
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
    
    func testDecodingError() throws {
        
        let exp = expectation(description: "Unsuccessful response")
        (networkService as? NetworkServiceMock)?.set(result: .failure(.decodingError))
        networkService.request(method: .GET, url: URL(string: "www.viaplay.com")!, cachePolicy: .returnCacheDataElseLoad) { (result: Result<NetworkResponseModel, NetworkError>) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Decoding error")
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 1)
    }
}
