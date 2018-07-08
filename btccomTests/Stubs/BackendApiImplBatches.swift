//
//  BackendApiImplStub.swift
//  btccomTests
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation
@testable import btccom

class BackendApiImplBatches : BackendApiProtocol {
    let batches : [[Order]]
    var counter = 0

    init(batches : [[Order]]) {
        self.batches = batches
    }

    func listOrders(start : Int, size : Int, completion : @escaping ([Order]?) -> Void) {
        if counter < batches.count {
            completion(batches[counter])
            counter += 1
        }
    }
}
