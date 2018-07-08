//
//  ModelTests.swift
//  btccomTests
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import XCTest
@testable import btccom


class ModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTwoOrdersFromJSON() {

        let network = NetworkImplFromBundle(jsonFileName: "TwoOrders")
        let parser = ParserImplDecodable()
        let api = BackendApiImplNetwork(network: network, parser: parser)

        let model = Model(api: api)

        let expectation = XCTestExpectation(description: "Updating model once")
        model.update { viewModel in
            XCTAssertEqual(viewModel.sellOrders.count, 2)
            XCTAssertEqual(viewModel.buyOrders.count, 0)
            XCTAssertEqual(viewModel.matches.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testNoMatchesOnStep1() {
        let api = BackendApiImplBatches(batches: [self.batch1])
        let model = Model(api: api)

        let expectation = XCTestExpectation(description: "Updating model once")
        model.update { viewModel in
            XCTAssertEqual(viewModel.sellOrders.count, 1)
            XCTAssertEqual(viewModel.buyOrders.count, 2)
            XCTAssertEqual(viewModel.matches.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testTwoMatchesOnStep2() {
        let api = BackendApiImplBatches(batches: [self.batch1, self.batch2])
        let model = Model(api: api)

        let expectation1 = XCTestExpectation(description: "Updating model first time")
        model.update { viewModel in
            XCTAssertEqual(viewModel.sellOrders.count, 1)
            XCTAssertEqual(viewModel.buyOrders.count, 2)
            XCTAssertEqual(viewModel.matches.count, 0)
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 1.0)

        let expectation2 = XCTestExpectation(description: "Updating model second time")
        model.update { viewModel in

            XCTAssertEqual(viewModel.sellOrders.count, 1)
            XCTAssertEqual(viewModel.sellOrders[0], Order(id: 1001, type: "sell", quantity: 6, price: 480))

            XCTAssertEqual(viewModel.buyOrders.count, 1)
            XCTAssertEqual(viewModel.buyOrders[0], Order(id: 1003, type: "buy", quantity: 3, price: 460))

            XCTAssertEqual(viewModel.matches.count, 2)

            let match1 = viewModel.matches[0]
            XCTAssertEqual(match1.volume, 8)
            XCTAssertEqual(match1.price, Decimal(465))

            let match2 = viewModel.matches[1]
            XCTAssertEqual(match2.volume, 2)
            XCTAssertEqual(match2.price, Decimal(460))

            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1.0)
    }

    private let batch1 = [Order(id: 1001, type: "sell", quantity: 6, price: 480),
                          Order(id: 1002, type: "buy", quantity: 8, price: 470),
                          Order(id: 1003, type: "buy", quantity: 5, price: 460)]
    private let batch2 = [Order(id: 1004, type: "sell", quantity: 10, price: 460)]
}
