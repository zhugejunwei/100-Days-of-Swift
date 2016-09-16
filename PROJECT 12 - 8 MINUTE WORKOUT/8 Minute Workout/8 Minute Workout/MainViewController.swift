//
//  MainViewController.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/14/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    let manager = WorkoutData()
    var workouts = [Workout]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.workouts = manager.getWorkOuts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workout = self.workouts[indexPath.row] 
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! WorkoutTableViewCell
        cell.textCell.text = workout.title
        cell.backgroundColor = workout.color
        cell.count.text = "\(indexPath.row + 1)"
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let cell = sender as? WorkoutTableViewCell
            let indexPath = tableView.indexPath(for: cell!)
            let nvc = segue.destination as? UINavigationController
            let tmp = workouts[indexPath!.row]
            let dvc = nvc?.topViewController as! DetailViewController
            dvc.workout = tmp
        
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake(0,0,55,0)
    }
    
}
