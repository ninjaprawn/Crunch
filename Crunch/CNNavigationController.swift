//
//  CNNavigationController.swift
//  Crunch
//
//  Created by George Dan on 13/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

enum LeftMenuButtonOptions {
    case Back
    case Sidebar
}

class CNNavigationController: UINavigationController {
    
    func nothing() {
        //ddd
    }
    
    var sidebarView = CNSideBarView(frame: CGRectMake(0, -20, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    var statusBG: UIView = UIView()
    var extended: UIView = UIView()
    var label: UILabel = UILabel()
    var leftMenuButton: UIButton = UIButton()
    var leftMenuButtonIcon: UIImageView = UIImageView()
    var leftMenuButtonOption: LeftMenuButtonOptions = .Sidebar
    var homeVC: CNHomeTableViewController = CNHomeTableViewController()
    var rightMenuButton: UIButton = UIButton()
    var rightMenuButtonIcon: UIImageView = UIImageView()
    var rightMenuButtonRefresh: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func imageResize (#image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = UIScreen.mainScreen().scale
        // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer.delegate = nil
        var navBar = self.navigationBar
        var ar: [AnyObject?] = []
        for view in navBar.subviews {
            var nView = view as! UIView
            var name = nView.nameOfClass
            if (name == "UINavigationItemButtonView" || name == "_UINavigationBarBackIndicatorView" || name == "UILabel") {
                nView.hidden = true
            }
        }
        
        statusBG = UIView(frame: CGRectMake(0, -20, self.navigationBar.frame.size.width, 20))
        statusBG.backgroundColor = UIColor(hex: 0x2E7D32)
        self.navigationBar.addSubview(statusBG)
        
        extended = UIView(frame: CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height+12))
        extended.backgroundColor = UIColor(hex: 0x4CAF50)
        extended.layer.shadowColor = UIColor.blackColor().CGColor
        extended.layer.shadowOffset = CGSize(width: 0, height: 3)
        extended.layer.shadowOpacity = 0.16
        extended.layer.shadowRadius = 2
        self.navigationBar.addSubview(extended)
        
        label = UILabel(frame: CGRectMake(72, ((self.navigationBar.frame.size.height+12)/2)-15, self.navigationBar.frame.size.width, 30))
        label.font = UIFont(name: "Roboto-Medium", size: 20)
        label.textColor = UIColor.whiteColor()
        label.text = "Home"
        self.navigationBar.addSubview(label)
        
        leftMenuButton = UIButton(frame: CGRectMake(2, ((self.navigationBar.frame.size.height+12)/2)-26, 52, 52))
        var menuImage = UIImage(named: "menu")!
        menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(24, 24))
        leftMenuButtonIcon = UIImageView(image: menuImage)
        leftMenuButtonIcon.frame = CGRectMake(14, 14, 24, 24)
        leftMenuButton.addSubview(leftMenuButtonIcon)
        //menuButton.setImage(menuImage, forState: .Normal)
        //menuButton.backgroundColor = UIColor(hex: 0x000000)
        leftMenuButton.addTarget(self, action: Selector("menuPressed:"), forControlEvents: UIControlEvents.TouchDown)
        leftMenuButton.addTarget(self, action: Selector("menuReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
        leftMenuButton.addTarget(self, action: Selector("menuReleased:"), forControlEvents: UIControlEvents.TouchUpOutside)
        self.navigationBar.addSubview(leftMenuButton)
        
        rightMenuButton = UIButton(frame: CGRectMake(self.navigationBar.frame.size.width-54, ((self.navigationBar.frame.size.height+12)/2)-26, 52, 52))
        var doneMenuImage = UIImage(named: "done")!
        doneMenuImage = self.imageResize(image: doneMenuImage, sizeChange: CGSizeMake(24, 24))
        rightMenuButtonIcon = UIImageView(image: doneMenuImage)
        rightMenuButtonIcon.frame = CGRectMake(14, 14, 24, 24)
        rightMenuButton.addSubview(rightMenuButtonIcon)
        rightMenuButtonRefresh.hidden = true
        rightMenuButtonRefresh.frame = CGRectMake(14,14,24,24)
        rightMenuButton.addSubview(rightMenuButtonRefresh)
        //menuButton.setImage(menuImage, forState: .Normal)
        //menuButton.backgroundColor = UIColor(hex: 0x000000)
        rightMenuButton.addTarget(self, action: Selector("donePressed:"), forControlEvents: UIControlEvents.TouchDown)
        rightMenuButton.addTarget(self, action: Selector("doneReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
        rightMenuButton.addTarget(self, action: Selector("doneReleased:"), forControlEvents: UIControlEvents.TouchUpOutside)
        self.navigationBar.addSubview(rightMenuButton)
        rightMenuButton.hidden = true

        
        sidebarView.hidden = true
        sidebarView.layer.shadowColor = UIColor.blackColor().CGColor
        sidebarView.layer.shadowOffset = CGSize(width: 3, height: 0)
        sidebarView.layer.shadowOpacity = 0.16
        sidebarView.layer.shadowRadius = 3
        sidebarView.navBar = self
        
        self.navigationBar.barTintColor = UIColor(hex: 0x4CAF50)
        self.navigationBar.tintColor = UIColor(hex: 0x4CAF50)
    }
    
    func beginRefresh() {
        rightMenuButton.hidden = false
        rightMenuButtonIcon.hidden = true
        rightMenuButtonRefresh.hidden = false
        rightMenuButtonRefresh.startAnimating()
    }
    
    func finishRefresh() {
        rightMenuButton.hidden = true
        rightMenuButtonIcon.hidden = false
        rightMenuButtonRefresh.hidden = true
        rightMenuButtonRefresh.stopAnimating()
    }
    
    func donePressed(sender:UIButton!) {
        sender.layer.cornerRadius = 26.0
        UIView.animateWithDuration(0.1, animations: {
            sender.backgroundColor = UIColor(hex: 0x6BB6A)
        })
    }
    
    func doneReleased(sender:UIButton) {
        UIView.animateWithDuration(0.1, animations: {
            sender.backgroundColor = UIColor(hex: 0x4CAF50)
        }, completion: { (succ) in
            sender.layer.cornerRadius = 0.0
        })
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
            self.navigationBar.addSubview(self.sidebarView)
        }, completion: { (succ) in
            sender.layer.cornerRadius = 0.0
            switch (self.leftMenuButtonOption) {
                case LeftMenuButtonOptions.Sidebar:
                    self.sidebarFunc()
                    break
                case LeftMenuButtonOptions.Back:
                    self.back()
                    break
                default:
                    self.sidebarFunc()
                    break
            }
        })
    }
    
    func sidebarFunc() {
        self.sidebarView.windowLevel = UIWindowLevelStatusBar+1
        self.sidebarView.hidden = false
        self.sidebarView.showAnimated()
    }
    
    func back() {
        self.popViewControllerAnimated(true)
        self.updateLeftMenuButtonOption(.Sidebar)
        self.updateNavText("Home")
    }
    
    func updateLeftMenuButtonOption(option: LeftMenuButtonOptions) {
        self.leftMenuButtonOption = option
        switch (self.leftMenuButtonOption) {
            case LeftMenuButtonOptions.Sidebar:
                var menuImage = UIImage(named: "menu")!
                menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(24, 24))
                leftMenuButtonIcon.image = menuImage
                break
            case LeftMenuButtonOptions.Back:
                var menuImage = UIImage(named: "back")!
                menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(24, 24))
                leftMenuButtonIcon.image = menuImage
                break
            default:
                var menuImage = UIImage(named: "menu")!
                menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(24, 24))
                leftMenuButtonIcon.image = menuImage
                break
        }
    }
    
    func updateNavText(string: String) {
        self.label.text = string
    }
    
}
