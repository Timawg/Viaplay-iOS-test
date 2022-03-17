//
//  ViewControllerFactoryTests.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import XCTest
@testable import Viaplay_test

class ViewControllerFactoryTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        InjectedValues().networkService = NetworkServiceMock()
    }

    func testSection() throws {
        let viewModel = ViewModelFactory.createViewModel(type: .section(nil, nil))
        let viewController = ViewControllerFactory.createViewController(type: .section(viewModel))
        XCTAssert(viewController is SectionsTableViewController)
    }
    
    func testDetail() throws {
        let viewModel = ViewModelFactory.createViewModel(type: .detail("", nil))
        let viewController = ViewControllerFactory.createViewController(type: .detail(viewModel))
        XCTAssert(viewController is DetailViewController)
    }
}
