//
//  BackendApiImplNetworkTests.swift
//  btccomTests
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import XCTest
@testable import btccom

class BackendApiImplNetworkTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTwoOrders() {

        let network = NetworkImplFromBundle(jsonFileName: "TwoOrders")
        let parser = ParserImplDecodable()
        let api = BackendApiImplNetwork(network: network, parser: parser)

        let expectation = XCTestExpectation(description: "Fetch orders from local file")
        api.listOrders(start: 0, size: 100) { (orders) in
            XCTAssertEqual(orders?.count, 2)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
