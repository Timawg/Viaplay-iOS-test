//
//  DetailViewModelTests.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import XCTest
@testable import Viaplay_test

class DetailViewModelTests: XCTestCase {

    @Injected(\.networkService) private var networkService: NetworkServiceProtocol

    func testSuccessfulRequest() throws {
        let service = NetworkServiceMock()
        let model = NetworkResponseModel(title: "Test", description: "Test Description", links: .init(viaplaySections: [.init(title: "Films", href: "www.viaplay.com/films")]))
        service.set(result: .success(model))
        InjectedValues().networkService = service
        let viewModel = ViewModelFactory.createViewModel(type: .detail("", URL(string: "www.viaplay.com")!)) as! DetailViewModel
        let exp = expectation(description: "Successful request")
        viewModel.onDataRetrieved = {
            XCTAssertEqual(viewModel.content.title, "Test")
            XCTAssertEqual(viewModel.content.description, "Test Description")
            exp.fulfill()
        }
        
        viewModel.retrieveData(ignoreCache: false)
        
        wait(for: [exp], timeout: 1)
    }
    
    func testFailedRequest() throws {
        let service = NetworkServiceMock()
        service.set(result: .failure(.error(nil)))
        InjectedValues().networkService = service
        let viewModel = ViewModelFactory.createViewModel(type: .detail("", URL(string: "www.viaplay.com")!)) as! DetailViewModel
        viewModel.retrieveData(ignoreCache: false)
        XCTAssertEqual(viewModel.content.title, "")
        XCTAssertEqual(viewModel.content.description, "")
    }

}
