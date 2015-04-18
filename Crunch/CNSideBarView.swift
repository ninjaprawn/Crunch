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
    var navBar: UINavigationController = UINavigationController()
    var selected = 0

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func imageResize (#image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = UIScreen.mainScreen().scale // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
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
        
        var label = UILabel(frame: CGRectMake(16, ((96)/2)-15, frame.size.width, 30))
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor.whiteColor()
        label.text = "Crunch"
        headerView.addSubview(label)

        
        contentView = UIView(frame: CGRectMake(-((frame.size.width/5)*4), 76, (frame.size.width/5)*4, frame.size.height-76))
        contentView.backgroundColor = UIColor.whiteColor()
        self.addSubview(contentView)
        
        self.addItems()
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
    
    func addItems() {
        var items = ["Home", "Subscribe", "Subscriptions", "Favourites"]
        var cy: CGFloat = 8.0
        var count = 0
        for item in items {
            
            var button = UIButton(frame: CGRectMake(0, cy, ((self.frame.size.width/5)*4), 48))
            button.tag = count
            button.addTarget(self, action: Selector("sidebarPressed:"), forControlEvents: UIControlEvents.TouchDown)
            button.addTarget(self, action: Selector("sidebarReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.addTarget(self, action: Selector("sidebarReleased:"), forControlEvents: UIControlEvents.TouchUpOutside)
            
            var label = CNLabel(frame: CGRectMake(0, 0, ((self.frame.size.width/5)*4), 48))
            label.font = UIFont(name: "Roboto-Medium", size: 14)
            //label.backgroundColor = UIColor.blueColor()
            label.text = item
            label.textColor = UIColor.blackColor()
            
            var lc = item.lowercaseString
            var imageIcon = UIImage(named: lc)!
            imageIcon = self.imageResize(image: imageIcon, sizeChange: CGSizeMake(22, 22))
            var imageIconView = UIImageView(image: imageIcon)
            imageIconView.frame = CGRectMake(16, 13, 22, 22)
            label.addSubview(imageIconView)
            
            button.addSubview(label)

            
            self.contentView.addSubview(button)
            cy += 48
            count++
        }
        self.setHighlighted(0)
    }
    
    func setHighlighted(position: Int) {
        UIView.animateWithDuration(0.2, animations: {
            for pos in 0...self.contentView.subviews.count-1 {
                var view: UIButton = self.contentView.subviews[pos] as! UIButton
                if pos == position {
                    view.backgroundColor = UIColor(hex: 0xf0f0f0)
                } else {
                    view.backgroundColor = UIColor.whiteColor()
                }
            }
        })
    }
    
    func sidebarPressed(sender: UIButton) {
        var num = sender.tag
        self.setHighlighted(num)
    }
    
    func sidebarReleased(sender: UIButton) {
        var tag = sender.tag
        if tag != self.selected {
            if tag == 0 {
                var nav = navBar as! CNNavigationController
                nav.popViewControllerAnimated(true)
                /*let vc : CNHomeTableViewController! = self.navBar.storyboard!.instantiateViewControllerWithIdentifier("homeVC") as! CNHomeTableViewController!
                self.navBar.pushViewController(vc, animated: true)*/
                nav.updateNavText("Home")
                nav.rightMenuButton.hidden = true
                self.shadowTapped()                
            } else if tag == 1 {
                var nav = navBar as! CNNavigationController
                nav.popViewControllerAnimated(true)
                let vc : CNAddViewController! = self.navBar.storyboard!.instantiateViewControllerWithIdentifier("subscribeVC") as! CNAddViewController!
                self.navBar.pushViewController(vc, animated: true)
                nav.updateNavText("Subscribe")
                self.shadowTapped()
            } else if tag == 2 {
                var nav = navBar as! CNNavigationController
                nav.popViewControllerAnimated(true)
                let vc : CNSubscribedViewController! = self.navBar.storyboard!.instantiateViewControllerWithIdentifier("subscribedVC") as! CNSubscribedViewController!
                self.navBar.pushViewController(vc, animated: true)
                nav.updateNavText("Subscribed")
                nav.rightMenuButton.hidden = true
                self.shadowTapped()
            } else {
                var nav = navBar as! CNNavigationController
                nav.popViewControllerAnimated(true)
                let vc : CNSubscribedViewController! = self.navBar.storyboard!.instantiateViewControllerWithIdentifier("subscribedVC") as! CNSubscribedViewController!
                self.navBar.pushViewController(vc, animated: true)
                nav.updateNavText("Favourites")
                nav.rightMenuButton.hidden = true
                self.shadowTapped()
            }
        }
        self.selected = tag
    }
}
