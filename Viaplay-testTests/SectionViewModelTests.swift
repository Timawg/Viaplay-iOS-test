//
//  SectionViewModelTests.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import XCTest
@testable import Viaplay_test

class SectionViewModelTests: XCTestCase {
    
    @Injected(\.networkService) private var networkService: NetworkServiceProtocol

    func testSuccessfulRequest() throws {
        let service = NetworkServiceMock()
        let model = NetworkResponseModel(title: "Test", description: "Test Description", links: .init(viaplaySections: [.init(title: "Films", href: "www.viaplay.com/films")]))
        service.set(result: .success(model))
        InjectedValues().networkService = service
        let viewModel = ViewModelFactory.createViewModel(type: .section(nil, nil)) as! SectionsViewModel
        let exp = expectation(description: "Successful request")
        viewModel.onDataRetrieved = {
            XCTAssertEqual(viewModel.model.title, "Test")
            XCTAssertEqual(viewModel.model.description, "Test Description")
            XCTAssertEqual(viewModel.model.links.viaplaySections.count, 1)
            XCTAssertEqual(viewModel.model.links.viaplaySections.first?.title, "Films")
            XCTAssertEqual(viewModel.model.links.viaplaySections.first?.href, "www.viaplay.com/films")
            exp.fulfill()
        }
        
        viewModel.retrieveData()
        
        wait(for: [exp], timeout: 1)
    }
    
    func testFailedRequest() throws {
        let service = NetworkServiceMock()
        service.set(result: .failure(.error(nil)))
        InjectedValues().networkService = service
        let viewModel = ViewModelFactory.createViewModel(type: .section(nil, nil)) as! SectionsViewModel
        let exp = expectation(description: "Failed request")
        viewModel.onDataRetrieved = {
            XCTAssertEqual(viewModel.model.title, "")
            XCTAssertEqual(viewModel.model.description, "")
            XCTAssertEqual(viewModel.model.links.viaplaySections.count, 0)
            XCTAssertEqual(viewModel.model.links.viaplaySections.first?.title, nil)
            XCTAssertEqual(viewModel.model.links.viaplaySections.first?.href, nil)
            exp.fulfill()
        }
        
        viewModel.retrieveData()
        
        wait(for: [exp], timeout: 1)
    }
}
