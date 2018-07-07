//
//  Order.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

// {"id":10,"side":"sell","quantity":13,"price":160}

struct Order : Decodable {

    enum Types : String {
        case sell
        case buy
        case unknown
    }

    let id : Int
    let type : String
    let quantity : Int
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
