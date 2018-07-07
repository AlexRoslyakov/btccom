//
//  ParserImplDecodableTests.swift
//  btccomTests
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import XCTest
@testable import btccom

class ParserImplDecodableTests: XCTestCase {
    private var parser : ParserProtocol!

    override func setUp() {
        super.setUp()
        self.parser = ParserImplDecodable()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTwoOrders() {
        let network = NetworkImplFromBundle(jsonFileName: "TwoOrders")
        guard let data = network.dataFromJsonFile() else {
            XCTAssert(false, "Failed to load test data")
            return
        }
        guard let orders = parser.parseOrders(data: data) else {
            XCTAssert(false, "Failed to parse data")
            return
        }

        XCTAssertEqual(orders.count, 2)

        // {"id":10,"side":"sell","quantity":13,"price":160}
        XCTAssertEqual(orders[0].id, 10)
        XCTAssertEqual(orders[0].type, "sell")
        XCTAssertEqual(orders[0].typeEnum(), Order.Types.sell)
        XCTAssertEqual(orders[0].quantity, 13)
        XCTAssertEqual(orders[0].price, 160)

        // {"id":11,"side":"sell","quantity":10,"price":87}
        XCTAssertEqual(orders[1].id, 11)
        XCTAssertEqual(orders[1].type, "sell")
        XCTAssertEqual(orders[1].typeEnum(), Order.Types.sell)
        XCTAssertEqual(orders[1].quantity, 10)
        XCTAssertEqual(orders[1].price, 87)
    }

    func testOneOrder() {
        let network = NetworkImplFromBundle(jsonFileName: "OneOrder")
        guard let data = network.dataFromJsonFile() else {
            XCTAssert(false, "Failed to load test data")
            return
        }
        guard let orders = parser.parseOrders(data: data) else {
            XCTAssert(false, "Failed to parse data")
            return
        }

        XCTAssertEqual(orders.count, 1)
    }

    func testHundredOrders() {
        let network = NetworkImplFromBundle(jsonFileName: "HundredOrders")
        guard let data = network.dataFromJsonFile() else {
            XCTAssert(false, "Failed to load test data")
            return
        }
        guard let orders = parser.parseOrders(data: data) else {
            XCTAssert(false, "Failed to parse data")
            return
        }

        XCTAssertEqual(orders.count, 100)
    }

    func testPerformanceHundredOrders() {
        let network = NetworkImplFromBundle(jsonFileName: "HundredOrders")
        guard let data = network.dataFromJsonFile() else {
            XCTAssert(false, "Failed to load test data")
            return
        }

        self.measure {
             for _ in 0..<100 {
                _ = parser.parseOrders(data: data)
            }
        }
    }
}
