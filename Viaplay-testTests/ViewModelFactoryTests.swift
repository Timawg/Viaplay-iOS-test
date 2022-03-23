//
//  ViewModelFactoryTests.swift
//  Viaplay-testTests
//
//  Created by Tim Gunnarsson on 2022-03-17.
//

import XCTest
@testable import Viaplay_test

class ViewModelFactoryTests: XCTestCase {
    
    func testSection() throws {
        guard let viewModel = ViewModelFactory.createViewModel(type: .section("Test", URL(string: "www.viaplay.com/test")!)) as? SectionsViewModel else {
            XCTFail("Incorrect viewModel type")
            return
        }
        XCTAssertEqual(viewModel.title, "Test")
    }

    func testSectionEmpty() throws {
        guard let viewModel = ViewModelFactory.createViewModel(type: .section(nil, nil)) as? SectionsViewModel else {
            XCTFail("Incorrect viewModel type")
            return
        }
        XCTAssertEqual(viewModel.title, "Viaplay")
    }
    
    func testDetail() throws {
        guard let viewModel = ViewModelFactory.createViewModel(type: .detail("Films", nil)) as? DetailViewModel else {
            XCTFail("Incorrect viewModel type")
            return
        }
        XCTAssertEqual(viewModel.title, "Films")
    }

    func testDetailEmpty() throws {
        guard let viewModel = ViewModelFactory.createViewModel(type: .detail("", nil)) as? DetailViewModel else {
            XCTFail("Incorrect viewModel type")
            return
        }
        XCTAssertEqual(viewModel.title, "")
    }
}
