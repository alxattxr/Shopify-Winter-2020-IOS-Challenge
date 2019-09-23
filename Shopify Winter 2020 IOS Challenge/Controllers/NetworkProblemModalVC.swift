//
//  NetworkProblemModalVC.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-21.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit

class NetworkProblemModalVC: UIViewController {
    
    @IBAction func goBackToMainMenu(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
