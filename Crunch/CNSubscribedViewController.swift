//
//  CNSubscribedViewController.swift
//  Crunch
//
//  Created by George Dan on 18/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNSubscribedViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            if feed[pos] == "" {
                feed.removeAtIndex(pos)
            }
            NSUserDefaults.standardUserDefaults().setObject(feed, forKey: "com.ninjaprawn.crunch/feeds")
            NSUserDefaults.standardUserDefaults().synchronize()
            return feed[pos]
        }
        return ""
    }
    
    // MARK: TableView DataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return numberOfSubscriptions()
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = self.feedForIndex(indexPath.row)
        cell.textLabel?.font = UIFont(name: "Roboto-Regular", size: 16)
        
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
            label.text = "RSS"
        } else if section == 1 {
            label.text = "Hashtags"
        } else if section == 2 {
            label.text = "Accounts"
        }
        label.textColor = UIColor(hex: 0x999999)
        label.verticalAlignment = .Middle
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
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
