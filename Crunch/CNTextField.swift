//
//  CNTextField.swift
//  Crunch
//
//  Created by George Dan on 18/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 0
        
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
