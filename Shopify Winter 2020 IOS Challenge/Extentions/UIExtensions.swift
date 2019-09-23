//
//  UIExtensions.swift
//  Shopify Winter 2020 IOS Challenge
//
//  Created by Alexandre Attar on 2019-09-22.
//  Copyright © 2019 AADevelopment. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func setInitialStyle(){
        self.backgroundColor = .clear
        self.tintColor = .clear
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.setSelectedAttribute(color: UIColor.white)
    }
    
    func setSelectedAttribute(color: UIColor){
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], for: .selected)
    }
}

extension UIView {
    func backgroundColorTransition(for color: UIColor){
        UIView.animate(withDuration: 0.4, delay: 0.0, options:[.curveEaseInOut], animations: {
            self.backgroundColor = color
        }, completion:nil)
    }
}

extension UITextField {
    
    func setMinimalStyleField() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor
    }
}
