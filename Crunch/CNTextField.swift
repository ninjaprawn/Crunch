//
//  CNTextField.swift
//  Crunch
//
//  Created by George Dan on 18/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNTextField: UITextField, UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 0
        self.tintColor = UIColor(hex: 0x2E7D32)
        
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor(hex: 0xDDDDDD).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height+1)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        self.delegate = self
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.layer.sublayers[0].removeFromSuperlayer()
        var border = CALayer()
        var width = CGFloat(2.0)
        border.borderColor = UIColor(hex: 0x2E7D32).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height+1)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println(self.layer.sublayers)
        for layer in self.layer.sublayers {
            var l = layer as! CALayer
            if NSStringFromClass(l.dynamicType) == "CALayer" {
                layer.removeFromSuperlayer()
            }
        }
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor(hex: 0xDDDDDD).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height+1)
        
        border.borderWidth = width
        self.layer.addSublayer(border)

    }
    
    
    
}
