//
//  CNHomeTableViewController.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNHomeTableViewController: UITableViewController {
    
    var blogTitle = "Today"
    var blogItems: [RSSItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "CNFeedTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "feedCell")
        
        let url = NSURL(string: "http://developer.apple.com/swift/blog/news.rss")
        
        let request = NSURLRequest(URL: url!)
        
        RSSParser.parseFeedForRequest(request, callback: { (feed, error) -> Void in
            if let error = error {
                println(error)
            } else {
                self.blogItems = feed!.items!
                self.blogTitle = feed!.title!
            }
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
        })
        var naviBar: CNNavigationController = self.navigationController as! CNNavigationController
        naviBar.homeVC = self as CNHomeTableViewController
        naviBar.updateNavText("Home")
        naviBar.updateLeftMenuButtonOption(LeftMenuButtonOptions.Sidebar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! CNFeedTableViewCell

        // Configure the cell...
        if self.blogItems.count > 0 {
            cell.updateCellWith(blogItems[indexPath.row].title!, description: blogItems[indexPath.row].itemDescription!)
            cell.updateImageForType(FeedType.RSS)
        }
        //println(self.blogItems)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRectMake(0, 12, tableView.frame.size.width, 26))
        
        var label = SOLabel(frame: CGRectMake(16, 12, tableView.frame.size.width, 26))
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = self.blogTitle
        label.textColor = UIColor(hex: 0x999999)
        label.verticalAlignment = .Middle
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var navBar: CNNavigationController = self.navigationController as! CNNavigationController
        navBar.updateNavText("")
        navBar.updateLeftMenuButtonOption(LeftMenuButtonOptions.Back)
        navBar.navigationItem.leftBarButtonItem = nil
        let vc : CNWebViewController! = self.storyboard!.instantiateViewControllerWithIdentifier("webView") as! CNWebViewController!
        
        vc.navigationItem.leftBarButtonItem = nil
        vc.navigationItem.backBarButtonItem = nil
        //let vcs = vc.childViewControllers
        //var webvc: CNWebViewController = vcs[0] as! CNWebViewController
        if self.blogItems.count > 0 {
            vc.link = self.blogItems[indexPath.row].link!
        } else {
            vc.link = NSURL(string: "https://twitter.com")!
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }


    /*r
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
