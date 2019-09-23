//
//  Products.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-14.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation

struct Products : Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let image: Image
}

struct Image: Codable {
    let id: Int
    let src: String
}


