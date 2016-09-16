//
//  LeftTableViewController.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/2/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class LeftTableViewController: UITableViewController {

    var dataSource = [NSArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = leftControllerAndRightControllerBGColor
        
        let nib = UINib(nibName: "LeftTableViewCell", bundle: NSBundle.mainBundle())
        
        self.tableView.registerNib(nib, forCellReuseIdentifier: "reuseIdentifier")
        
        self.tableView.rowHeight = 100
        
        self.tableView.separatorStyle = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LeftTableViewController.refreshData(_:)), name: LeftControllerTypeChangedNotification, object: nil)
    }
    
    func refreshData(sender: NSNotification) {
        let info = sender.userInfo!["data"] as! NSArray
        dataSource.append(info)
        print(dataSource[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! LeftTableViewCell

//        let dayWeatherInfo = self.dataSource[indexPath.row]
//        cell.dateLabel.text = "04/09"
//        cell.weekDayLabel.text = "Sunday"
//        cell.tempLabel.text = (dayWeatherInfo[2] as? String)! + "~" + (dayWeatherInfo[1] as? String)!
//        cell.weatherLabel.text = dayWeatherInfo[0] as? String
//        cell.weatherBgView.backgroundColor = Tool.returnWeatherBGColor(dayWeatherInfo[0] as! String)
        
        if indexPath.row == 1 {
            cell.dateLabel.text = "04/09"
            cell.weekDayLabel.text = "Today"
        }
        
        if indexPath.row == 2 {
            cell.dateLabel.text = "04/09"
            cell.weekDayLabel.text = "Tomorrow"
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtI ndexPath indexPath: NSIndexPath) -> Bool {
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
