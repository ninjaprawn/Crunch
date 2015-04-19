//
//  CNFavouritesTableViewController.swift
//  Crunch
//
//  Created by George Dan on 19/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

class CNFavouritesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "CNFeedTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "feedCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRectMake(0, 12, tableView.frame.size.width, 26))
        
        var label = SOLabel(frame: CGRectMake(16, 12, tableView.frame.size.width, 26))
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.text = ""
        label.textColor = UIColor(hex: 0x999999)
        label.verticalAlignment = .Middle
        headerView.addSubview(label)
        
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("feedCell", forIndexPath: indexPath) as! CNFeedTableViewCell

        // Configure the cell...
        if indexPath.row == 0 {
            cell.updateCellWith("George Dan (ninja) - @theninjaprawn", description: "Progressing on my #HSHACT project very well. #CBRIN")
            cell.updateImageForType(FeedType.Twitter)
        } else if indexPath.row == 1 {
            cell.updateCellWith("Empowering people to do great work", description: "On Thursday, Satya Nadella participated in the White House")
            cell.updateImageForType(FeedType.RSS)
        } else if indexPath.row == 2 {
            cell.updateCellWith("Microsoft - @microsoft", description: "We’ve met an amazing group of people who #DoMore, but we know we haven’t met them all. In the comments ")
            cell.updateImageForType(FeedType.Instagram)
        }




        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }

    /*
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
