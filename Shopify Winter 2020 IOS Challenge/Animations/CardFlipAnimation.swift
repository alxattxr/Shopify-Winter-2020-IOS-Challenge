//
//  CardFlipAnimation.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-12.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func cardFlip(){
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
}
