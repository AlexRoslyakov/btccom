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

    var lastStartIndex : Int
    let sizeToFetch = 100

    var sellOrders = [Order]()
    var buyOrders = [Order]()
    var matches = [Match]()

    init(api : BackendApiProtocol) {
        self.lastStartIndex = 0
        self.api = api
    }

    func update(completion : @escaping () -> Void) {
        self.api.listOrders(start: self.lastStartIndex, size: sizeToFetch) { (orders) in
            guard let orders = orders else {
                return
            }

            self.lastStartIndex += orders.count

            self.updateSellOrdersWithNew(orders: orders)
            self.updateBuyOrdersWithNew(orders: orders)

            self.updateMatches()

            completion()
        }
    }

    private func updateSellOrdersWithNew(orders : [Order]) {
        let newSellOrders = orders.filter({ (order) -> Bool in
            return order.typeEnum() == Order.Types.sell
        })
        self.sellOrders.append(contentsOf: newSellOrders)
        self.sellOrders.sort(by: { (order1, order2) -> Bool in
            order1.price > order2.price
        })
    }

    private func updateBuyOrdersWithNew(orders : [Order]) {
        let newBuyOrders = orders.filter({ (order) -> Bool in
            return order.typeEnum() == Order.Types.buy
        })
        self.buyOrders.append(contentsOf: newBuyOrders)
        self.buyOrders.sort(by: { (order1, order2) -> Bool in
            order1.price < order2.price
        })
    }

    private func updateMatches() {
        while let indecies = findNextMatchIndecies() {
            let sellOrderIndex = indecies.0
            let buyOrderIndex = indecies.1

            let sellOrder = self.sellOrders[sellOrderIndex]
            let buyOrder = self.buyOrders[buyOrderIndex]

            let price = (Decimal(sellOrder.price) + Decimal(buyOrder.price))/Decimal(2)
            let volume = min(sellOrder.quantity,buyOrder.quantity)
            let match = Match(time: Date(), price: price, sellOrder: sellOrder, buyOrder: buyOrder, volume: volume)
            self.matches.append(match)

            if sellOrder.quantity > buyOrder.quantity {
                self.sellOrders[sellOrderIndex].quantity -= volume
                self.buyOrders.remove(at: buyOrderIndex)
            }
            else
            if sellOrder.quantity < buyOrder.quantity {
                self.buyOrders[buyOrderIndex].quantity -= volume
                self.sellOrders.remove(at: sellOrderIndex)
            }
            else {
                self.buyOrders.remove(at: buyOrderIndex)
                self.sellOrders.remove(at: sellOrderIndex)
            }
        }
    }

    func findNextMatchIndecies() -> (Int, Int)? {
        for (sellOrderIndex, sellOrder) in self.sellOrders.enumerated() {
            for (buyOrderIndex, buyOrder) in self.buyOrders.reversed().enumerated() {
                if sellOrder.price > buyOrder.price {
                    break
                }

                let unreversedBuyOrderIndex = self.buyOrders.count - 1 - buyOrderIndex
                return (sellOrderIndex, unreversedBuyOrderIndex)
            }
        }

        return nil
    }
}
