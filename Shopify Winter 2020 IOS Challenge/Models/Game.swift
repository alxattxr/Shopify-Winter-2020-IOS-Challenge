//
//  Game.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-21.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

struct Game {
    var isOver: Bool
    var difficulty: Difficulty
    var connection: Bool
    var turn: String
    var win: Int
    
    init() {
        self.isOver = false
        self.difficulty = .Easy
        self.connection = true
        self.turn = ""
        self.win = 0
    }
    
    init(win: Int, turn: String) {
        self.isOver = false
        self.difficulty = .Easy
        self.connection = true
        self.turn = turn
        self.win = win
    }
}
