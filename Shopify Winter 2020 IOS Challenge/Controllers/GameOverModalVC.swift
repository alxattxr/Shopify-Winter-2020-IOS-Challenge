//
//  GameOverModalVC.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-22.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit

class GameOverModalVC: UIViewController {
    
    var player: String = "player"

    @IBAction func playAgain(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var winnerMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerMessageLabel.text = "Congradulations to \(player)"
    }
}
