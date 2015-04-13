//
//  CNNavigationController.swift
//  Crunch
//
//  Created by George Dan on 13/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

class CNNavigationController: UINavigationController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var statusBG = UIView(frame: CGRectMake(0, -20, self.navigationBar.frame.size.width, 20))
        statusBG.backgroundColor = UIColor(hex: 0x2E7D32)
        self.navigationBar.addSubview(statusBG)
        
        var extended = UIView(frame: CGRectMake(0, self.navigationBar.frame.size.height, self.navigationBar.frame.size.width, 12))
        extended.backgroundColor = UIColor(hex: 0x4CAF50)
        /*extended.layer.shadowColor = UIColor.blackColor().CGColor
        extended.layer.shadowOffset = CGSize(width: 0, height: 7)
        extended.layer.shadowOpacity = 0.16
        extended.layer.shadowRadius = 3*/
        self.navigationBar.addSubview(extended)
        
        var label = UILabel(frame: CGRectMake(72, ((self.navigationBar.frame.size.height+40)/2)-30, self.navigationBar.frame.size.width, 30))
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor.whiteColor()
        label.text = "Crunch"
        self.navigationBar.addSubview(label)
        
        self.navigationBar.barTintColor = UIColor(hex: 0x4CAF50)
    }
    
}
