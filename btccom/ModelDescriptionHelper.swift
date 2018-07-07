//
//  ModelDescriptionHelper.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 08/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

class ModelDescriptionHelper {
    static func textFor(order : Order) -> String {
        return "\(order.type) #\(order.id) - \(order.quantity)x\t\(order.price)"
    }

    static func textFor(match : Match) -> String {
        return "Match \(match.volume)x\t\(match.price)"
    }
}
