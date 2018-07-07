//
//  ParserImplDecodable.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

class ParserImplDecodable {
    func parseOrders(data : Data) -> [Order]? {
        let decoder = JSONDecoder()
        if let orders = try? decoder.decode([Order].self, from: data) {
            return orders
        }

        return nil
    }
}
