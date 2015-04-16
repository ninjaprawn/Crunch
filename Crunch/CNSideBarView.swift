//
//  CNSideBarView.swift
//  Crunch
//
//  Created by George Dan on 14/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNSideBarView: UIWindow, UIGestureRecognizerDelegate {
    
    var headerView: UIView = UIView()
    var contentView: UIView = UIView()
    var shadowButton: UIButton = UIButton()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shadowButton = UIButton(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        shadowButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        shadowButton.addTarget(self, action: Selector("shadowTapped"), forControlEvents: UIControlEvents.TouchUpInside)
        shadowButton.addTarget(self, action: Selector("shadowTapped"), forControlEvents: UIControlEvents.TouchUpOutside)
        shadowButton.alpha = 0.0
        self.addSubview(shadowButton)
        
        headerView = UIView(frame: CGRectMake(-((frame.size.width/5)*4), 0, (frame.size.width/5)*4, 76))
        headerView.backgroundColor = UIColor(hex: 0x4CAF50)
        self.addSubview(headerView)
        
        contentView = UIView(frame: CGRectMake(-((frame.size.width/5)*4), 76, (frame.size.width/5)*4, frame.size.height-76))
        contentView.backgroundColor = UIColor.whiteColor()
        self.addSubview(contentView)
    }
    
    func shadowTapped() {
        UIView.animateWithDuration(0.2, animations: {
            self.shadowButton.alpha = 0.0
            self.headerView.frame.origin.x = -((self.frame.size.width/5)*4)
            self.contentView.frame.origin.x = -((self.frame.size.width/5)*4)
        }, completion: { (success) in
            self.userInteractionEnabled = false
        })
    }
    
    func showAnimated() {
        UIView.animateWithDuration(0.2, animations: {
            self.shadowButton.alpha = 1.0
            self.headerView.frame.origin.x = 0
            self.contentView.frame.origin.x = 0
        })
        self.userInteractionEnabled = true
    }
}
