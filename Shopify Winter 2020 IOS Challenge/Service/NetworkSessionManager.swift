//
//  NetworkSessionManager.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-14.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation
import UIKit

class NetworkSessionManager {
    //UrlSession => shared used since we don't need to obtain data incrementally
    //And we don't extra configuration
    let session = URLSession.init(configuration: .default)

    
    //This could be generic to accept different kind of data but for the purpose of this application it will do
    //else change type to Generic Type to reutilisable networkTask method
    func networkTask(with url: URLRequest, completionHandler completion: @escaping (Products?, NetworkError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil, .clientError)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .requestFail)
                return
            }
            
            if (200...299).contains(response.statusCode) {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let products = try decoder.decode(Products.self, from: data)
                    completion(products, nil)
                } catch {
                    completion(nil, .dataConversionFail)
                }
            } else {
                completion(nil, .responseUnsuccesful)
            }
        }
        return task
    }
}
