//
//  Model.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

class Model {
    private let api : BackendApiProtocol

    var sellOrders = [Order]()
    var buyOrders = [Order]()

    init(api : BackendApiProtocol) {
        self.api = api
    }

    func update(completion : @escaping () -> Void) {
        self.api.listOrders(start: 0, size: 100) { (orders) in
            guard let orders = orders else {
                return
            }

            self.sellOrders = orders.filter({ (order) -> Bool in
                return order.typeEnum() == Order.Types.sell
            })
            self.buyOrders = orders.filter({ (order) -> Bool in
                return order.typeEnum() == Order.Types.buy
            })
            
            completion()
        }
    }
}
