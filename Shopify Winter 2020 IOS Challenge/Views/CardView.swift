//
//  CardView.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-15.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import Foundation
import UIKit

class CardView: UICollectionViewCell {
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    func setView(with backgroundColor: UIColor, anImage: UIImage){
        self.testView.layer.cornerRadius = 5
        self.testView.layer.masksToBounds = true
        self.testView.backgroundColor = backgroundColor
        self.image.image = anImage
        self.testView.layer.borderColor = UIColor.darkGray.cgColor
        self.testView.layer.borderWidth = 1
    }
    
    func removeCard() {
        self.testView.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
}
