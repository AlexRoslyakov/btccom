//
//  NetworkProtocol.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func fetchDataFrom(url : URL, completion: @escaping (Data?) -> Void)
}
