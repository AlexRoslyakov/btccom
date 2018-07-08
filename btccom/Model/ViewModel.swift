//
//  ViewModel.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 08/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

struct ViewModel {
    let sellOrders : [Order]
    let buyOrders : [Order]
    let matches : [Match]

    init() {
        self.init(sellOrders: [], buyOrders: [], matches: [])
    }

    init(sellOrders : [Order], buyOrders : [Order], matches : [Match]) {
        self.sellOrders = sellOrders
        self.buyOrders = buyOrders
        self.matches = matches
    }
}
