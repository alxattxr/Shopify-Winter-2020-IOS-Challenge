//
//  APIClient.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-18.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation

class APIClient {
    let baseURL = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"

    let downloader = NetworkSessionManager()
    let decoder = JSONDecoder()

    func getShopifyStoreData(completionHandler completion: @escaping (Products?, NetworkError?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil, .invalidURL)
            return
        }

        let request = URLRequest(url: url)


        let task = downloader.networkTask(with: request) { (json, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let products = json as Products? else {
                    completion(nil, .parsingError)
                    return
                }
                completion(products, nil)
            }
        }
        task.resume()
    }
}
