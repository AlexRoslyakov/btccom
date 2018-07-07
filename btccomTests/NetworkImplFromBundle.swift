//
//  NetworkImplFromBundle.swift
//  btccomTests
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation
@testable import btccom

class NetworkImplFromBundle {
    let jsonFileName : String

    init(jsonFileName : String) {
        self.jsonFileName = jsonFileName
    }

    func dataFromJsonFile() -> Data? {
        guard let path = Bundle(for: NetworkImplFromBundle.self).path(forResource: self.jsonFileName, ofType: "json") else {
            precondition(false, "Failed to find resource")
        }

        guard let url = URL(string: "file://\(path)") else {
            precondition(false, "Can't builf URL from path: \(path)")
        }
        return try? Data(contentsOf: url)
    }
}

extension NetworkImplFromBundle : NetworkProtocol {

    func fetchDataFrom(url : URL, completion: @escaping (Data?) -> Void) {
        let data = self.dataFromJsonFile()
        completion(data)
    }

}
