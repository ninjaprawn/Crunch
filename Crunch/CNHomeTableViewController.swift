//
//  CNHomeTableViewController.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNHomeTableViewController: UITableViewController {
    
    var blogTitles: [String?] = []
    var blogItems: [[RSSItem]?] = []
    var firstTime: Bool = true
    //var refreshControl:UIRefreshControl! = UIRefreshControl()
    
    func numberOfSubscriptions() -> Int {
        if let feeds: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("com.ninjaprawn.crunch/feeds") {
            var feed: [String] = feeds as! [String]
            var c = 0
            for f in feed {
                if f != "" {
                    c++
                }
            }
            return c
        }
        return 1

    }
    
    func feedForIndex(pos: Int) -> String {
        if let feeds: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("com.ninjaprawn.crunch/feeds") {
            var feed: [String] = feeds as! [String]
            return feed[pos]
        }
        return "http://blogs.microsoft.com/feed/"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "CNFeedTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "feedCell")
        var naviBar: CNNavigationController = self.navigationController as! CNNavigationController
        
        for pos in 0...0 {
            var uri = feedForIndex(pos)
            let url = NSURL(string: uri)
            naviBar.beginRefresh()
        
            let request = NSURLRequest(URL: url!)
            
            RSSParser.parseFeedForRequest(request, callback: { (feed, error) -> Void in
                
                if let error = error {
                    println(error)
                } else {
                    self.blogItems.append(feed!.items!)
                    self.blogTitles.append(feed!.title!)
                    naviBar.finishRefresh()
                    naviBar.rightMenuButton.hidden = true
                    self.refreshControl?.endRefreshing()
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                    self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
                }
                //self.tableView.reloadSections(NSIndexSet(indexesInRange: 0...self.numberOfSubscriptions()-1)), withRowAnimation: .Automatic)
            })
        }
        naviBar.homeVC = self as CNHomeTableViewController
        naviBar.updateNavText("Home")
        naviBar.updateLeftMenuButtonOption(LeftMenuButtonOptions.Sidebar)
    }
    
    func refresh(sender: UIScreenEdgePanGestureRecognizer) {
        self.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.numberOfSubscriptions()+2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.blogItems.count > 0 && self.blogItems.count-1 >= section {
                if let itms = self.blogItems[section] {
                    if itms.count > 0 {
                        return itms.count
                    }
                    return 0
                }
                return 0
            }
            return 0
        }
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! CNFeedTableViewCell

        // Configure the cell...
        if indexPath.section == 0 {
            if self.blogItems.count > 0 {
                if let item = blogItems[indexPath.section] {
                    cell.updateCellWith(item[indexPath.row].title!, description: item[indexPath.row].itemDescription!)
                }
                cell.updateImageForType(FeedType.RSS)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.updateCellWith("George Dan (ninja) - @theninjaprawn", description: "The beginners from #HSHact who won the Twitter prizes gave all beginners false hope. The opens shall win the next one >:) #CBRIN")
                cell.updateImageForType(FeedType.Twitter)
            } else if indexPath.row == 1 {
                cell.updateCellWith("George Dan (ninja) - @theninjaprawn", description: "Day 2 coming to an end #HSHACT #CBRIN")
                cell.updateImageForType(FeedType.Twitter)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.updateCellWith("Microsoft - @microsoft", description: "After the economy crashed, #Detroit native Henry Ford II felt that something was missing from his life.")
                cell.updateImageForType(FeedType.Instagram)
            } else if indexPath.row == 1 {
                cell.updateCellWith("Microsoft - @microsoft", description: "Devin Sinha wants to inspire others to follow more than one passion in life, and he’s leading by example.")
                cell.updateImageForType(FeedType.Instagram)
            }
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
        if section == 0 {
            if self.blogTitles.count > 0 {
                if let obj = self.blogTitles[section] {
                    label.text = obj
                }
            } else {
                label.text = ""
            }
        } else if section == 1 {
            label.text = ""
        } else if section == 2 {
            label.text = ""
        }
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
            vc.link = self.blogItems[indexPath.section]![indexPath.row].link!
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
