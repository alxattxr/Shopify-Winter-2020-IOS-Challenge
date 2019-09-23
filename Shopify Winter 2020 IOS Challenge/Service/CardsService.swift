////
////  CardsService.swift
////  Shopify Winter 2020 IOS Challenge
////
////  Created by Alexandre Attar on 2019-09-12.
////  Copyright © 2019 AADevelopment. All rights reserved.
////
//
//import Foundation
//
//class CardsService {
//    let session = URLSession.shared
//    let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!
//    
//    func networkTask(with request: URLRequest, completionHandler completion: @escaping ([Products]?, NetworkSessionError?) -> ()){
//
//        let task = session.dataTask(with: url) { data, response, error in
//            
//            guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
//                completion(nil, .invalidURL)
//                return
//            }
//            
//            if error != nil || data == nil {
//                print("Client error!")
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                print("Server error!")
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                var ar: [String] = []
//                var arr: [Int] = []
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let test = try decoder.decode(Products.self, from: data!)
//                //        var json = try JSONSerialization.jsonObject(with: data!, options: [])
//                for i in test.products[10...11] {
//                    if (!ar.contains(i.image.src) && !arr.contains(i.image.id)){
//                        let img = URL(string: "\(i.image.src)")
//                        print(formatString(i.image.src))
//                        ar.append(i.image.src)
//                        arr.append(i.image.id)
//                    }
//                }
//                
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }
//        
//        task.resume()
//    }
//}
