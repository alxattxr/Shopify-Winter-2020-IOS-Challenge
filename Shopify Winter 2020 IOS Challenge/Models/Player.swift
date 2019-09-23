//
//  Player.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-13.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation

struct Player {
    var name: String
    var score: Int
    
    init(){
        self.name = ""
        self.score = 0
    }
    
    init(name: String, score: Int){
        self.name = name
        self.score = score
    }
}
