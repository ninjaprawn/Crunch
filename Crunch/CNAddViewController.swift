//
//  CNAddViewController.swift
//  Crunch
//
//  Created by George Dan on 18/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNAddViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var rssTextField: CNTextField!
    @IBOutlet weak var hashtagTextField: CNTextField!
    @IBOutlet weak var atTextField: CNTextField!
    @IBOutlet weak var instaTextField: CNTextField!
    
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

        // Do any additional setup after loading the view.
        var menuImage = UIImage(named: "rss-outline")!
        menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(20, 20))
        imageView.image = menuImage
        
        menuImage = UIImage(named: "instagram-outline")!
        menuImage = self.imageResize(image: menuImage, sizeChange: CGSizeMake(20, 20))
        instaImageView.image = menuImage
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("backgroundTapped"))
        self.view.addGestureRecognizer(tapGesture)
        
        var navbar = self.navigationController as! CNNavigationController
        navbar.rightMenuButton.hidden = false
        navbar.rightMenuButtonIcon.hidden = false
        navbar.rightMenuButton.addTarget(self, action: Selector("done:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func addFeed(feed:String) {
        if let feedObj: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("com.ninjaprawn.crunch/feeds") {
            var feeds: [String] = feedObj as! [String]
            feeds.append(feed)
            NSUserDefaults.standardUserDefaults().setObject(feeds, forKey: "com.ninjaprawn.crunch/feeds")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            NSUserDefaults.standardUserDefaults().setObject([feed], forKey: "com.ninjaprawn.crunch/feeds")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func done(sender: UIButton) {
        UIView.animateWithDuration(0.1, animations: {
            sender.backgroundColor = UIColor(hex: 0x4CAF50)
        }, completion: { (succ) in
            sender.layer.cornerRadius = 0.0
            if let str = self.rssTextField.text {
                if let url = NSURL(string: self.rssTextField.text) {
                    if self.rssTextField.text != "" {
                        //self.addFeed(self.rssTextField.text)
                        /*var navbar = self.navigationController as! CNNavigationController
                        navbar.popViewControllerAnimated(true)
                        navbar.rightMenuButton.hidden = true
                        navbar.sidebarView.setHighlighted(0)
                        navbar.sidebarView.selected = 0*/
                    }
                }
            }
        })
    }
    
    func backgroundTapped() {
        self.rssTextField.endEditing(false)
        self.hashtagTextField.endEditing(false)
        self.atTextField.endEditing(false)
        self.instaTextField.endEditing(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
