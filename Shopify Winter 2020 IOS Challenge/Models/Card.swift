//
//  Card.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-12.
//  Copyright © 2019 AADevelopment. All rights reserved.
//
import UIKit

struct Card {
    let id: Int
    let name: String
    let image: UIImage
    var relations: Int
    var isOpen: Bool
    var found: Bool
    
    init(id:Int, name: String, image: UIImage){
        self.id = id
        self.name = name
        self.image = image
        self.relations = 2
        self.isOpen = false
        self.found = false
    }
    
    func setRelations(for difficulty: Difficulty){
        if (difficulty != Difficulty.Easy) {
            
        }
    }
}

