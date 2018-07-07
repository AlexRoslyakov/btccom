//
//  Order.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

struct Order : Decodable {

    enum Types : String {
        case sell
        case buy
        case unknown
    }

    let id : Int
    let type : String
    var quantity : Int
    let price : Int

    func typeEnum() -> Types {
        if (type == Types.sell.rawValue) {
            return .sell
        }
        else
        if (type == Types.buy.rawValue) {
            return .buy
        }
        else {
            return .unknown
        }
    }
}

extension Order : Equatable {
    public static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id && lhs.price == rhs.price && lhs.quantity == rhs.quantity && lhs.type == rhs.type
    }
}
