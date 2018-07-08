//
//  NetworkImplURLSession.swift
//  btccom
//
//  Created by aleksandr.rosliakov on 07/07/2018.
//  Copyright © 2018 Alex Roslyakov. All rights reserved.
//

import Foundation

class NetworkImplURLSession : NetworkProtocol {

    func fetchDataFrom(url : URL, completion: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil)
            }

            completion(data)
        }
        task.resume()
    }
}
