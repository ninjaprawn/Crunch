//
//  CNLabel.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNLabel: UILabel {
   
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 72.0, bottom: 0.0, right: 0.0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
}
