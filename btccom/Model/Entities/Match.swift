//
//  Match.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

struct Match {
    let time : Date
    let price : Decimal
    let sellOrder : Order
    let buyOrder : Order
    let volume : Int
}
