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

    enum Sides : String {
        case sell
        case buy
        case unknown
    }

    let id : Int
    let side : String
    let quantity : Int
    let price : Int

    func sideType() -> Sides {
        if (side == Sides.sell.rawValue) {
            return .sell
        }
        else
        if (side == Sides.buy.rawValue) {
            return .buy
        }
        else {
            return .unknown
        }
    }
}
