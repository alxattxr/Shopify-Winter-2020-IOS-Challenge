//
//  NetworkError.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-12.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case clientError
    case requestFail
    case responseUnsuccesful
    case dataConversionFail
    case invalidURL
    case parsingError
    case invalidData
}
