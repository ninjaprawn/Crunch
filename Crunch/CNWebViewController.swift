//
//  CNWebViewController.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self)
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(self.dynamicType)
    }
}

class CNWebViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var webView: UIWebView!
    var link: NSURL = NSURL(string: "http://google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var navBar = self.navigationController!.navigationBar
        for view in navBar.subviews {
            var nView = view as! UIView
            var name = nView.nameOfClass
            if (name == "UINavigationItemButtonView" || name == "_UINavigationBarBackIndicatorView") {
                nView.hidden = true
            }
        }
        // Do any additional setup after loading the view.
        webView.loadRequest(NSURLRequest(URL: self.link))
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
