//
//  BackendApiImpl.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

class BackendApiImplNetwork : BackendApiProtocol {
    private let serverUrl = "http://localhost:5001/"
    private let network : NetworkProtocol
    private let parser : ParserProtocol

    init(network : NetworkProtocol, parser : ParserProtocol) {
        self.network = network
        self.parser = parser
    }

    func listOrders(start : Int, size : Int, completion : @escaping ([Order]?) -> Void) {
        guard let url = URL(string: "\(serverUrl)listOrders/?start=\(start)&size=\(size)") else {
            precondition(false, "Failed to generate URL")
        }
        self.network.fetchDataFromUrl(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }

            guard let orders = self.parser.parseOrders(data: data) else {
                completion(nil)
                return
            }

            completion(orders)
        }
    }
}
