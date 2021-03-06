//
//  BackendApiProtocol.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

protocol BackendApiProtocol {
    func listOrders(start : Int, size : Int, completion : @escaping ([Order]?) -> Void)
}
