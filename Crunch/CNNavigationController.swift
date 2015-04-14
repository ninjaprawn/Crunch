//
//  CNNavigationController.swift
//  Crunch
//
//  Created by George Dan on 13/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNNavigationController: UINavigationController {
    
    func imageResize (#image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
   
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
        
        var label = UILabel(frame: CGRectMake(72, ((self.navigationBar.frame.size.height+12)/2)-15, self.navigationBar.frame.size.width, 30))
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor.whiteColor()
        label.text = "Crunch"
        self.navigationBar.addSubview(label)
        
        var menuButton = UIButton(frame: CGRectMake(2, ((self.navigationBar.frame.size.height+12)/2)-26, 52, 52))
        var menuImage = UIImage(named: "menu")!
        menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(24, 24))
        var menuImageView = UIImageView(image: menuImage)
        menuImageView.frame = CGRectMake(14, 14, 24, 24)
        menuButton.addSubview(menuImageView)
        //menuButton.setImage(menuImage, forState: .Normal)
        //menuButton.backgroundColor = UIColor(hex: 0x000000)
        menuButton.addTarget(self, action: Selector("menuPressed:"), forControlEvents: UIControlEvents.TouchDown)
        menuButton.addTarget(self, action: Selector("menuReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
        menuButton.addTarget(self, action: Selector("menuReleased:"), forControlEvents: UIControlEvents.TouchUpOutside)
        self.navigationBar.addSubview(menuButton)
        
        self.navigationBar.barTintColor = UIColor(hex: 0x4CAF50)
    }
    
    func menuPressed(sender:UIButton!) {
        sender.layer.cornerRadius = 26.0
        UIView.animateWithDuration(0.1, animations: {
            sender.backgroundColor = UIColor(hex: 0x66BB6A)
        })
    }
    
    func menuReleased(sender:UIButton!) {
        UIView.animateWithDuration(0.1, animations: {
            sender.backgroundColor = UIColor(hex: 0x4CAF50)
        }, completion: { (succ) in
            sender.layer.cornerRadius = 0.0
        })
    }
    
}
