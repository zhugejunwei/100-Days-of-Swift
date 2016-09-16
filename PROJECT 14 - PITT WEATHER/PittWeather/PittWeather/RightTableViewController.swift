//
//  RightTableViewController.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/2/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class RightTableViewController: UITableViewController {

    // 需要从本地存储
    let historyCity = ["Pittsburgh", "New York", "Washington"]
    
    let sectionTitle0 = ["Reminder", "Setting", "Contact"]
    let sectionImage0 = ["reminder", "setting_right", "contact"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = leftControllerAndRightControllerBGColor
        
        let nib = UINib(nibName: "RightTableViewCell", bundle: NSBundle.mainBundle())
        
        self.tableView.registerNib(nib, forCellReuseIdentifier: "reuseIdentifier")
        
        self.tableView.rowHeight = 70
        
        self.tableView.separatorStyle = .None
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else {
            return 2 + historyCity.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! RightTableViewCell

        if indexPath.section == 0 {
            cell.titleLabel.text = sectionTitle0[indexPath.row]
            cell.indicatorImageView.image = UIImage(named: sectionImage0[indexPath.row])
            cell.deleteImageView.hidden = true
        }else {
            if indexPath.row == 0 {
                cell.titleLabel.text = "Add"
                cell.indicatorImageView.image = UIImage(named: "addcity")
                cell.deleteImageView.hidden = true
            }else if indexPath.row == 1 {
                cell.titleLabel.text = "Location"
                cell.indicatorImageView.image = UIImage(named: "city")
                cell.deleteImageView.hidden = true
            }else {
                cell.titleLabel.text = sectionTitle0[indexPath.row - 2]
                cell.indicatorImageView.image = UIImage(named: "city")
                cell.deleteImageView.hidden = false
            }
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 30
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel(frame: CGRectMake(0,0,self.view.frame.size.width,0))

            return label
        }else {
            let label = UILabel(frame: CGRectMake(0,0,self.view.frame.size.width,30))
            label.text = "Edit City"
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.backgroundColor = UIColor.blackColor()
            return label
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
