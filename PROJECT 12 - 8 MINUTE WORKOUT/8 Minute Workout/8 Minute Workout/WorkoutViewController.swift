//
//  WorkoutViewController.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/15/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit
import MZTimerLabel

class WorkoutViewController: UIViewController, MZTimerLabelDelegate {

    @IBOutlet weak var nextUp: UILabel!
    @IBOutlet weak var workoutlabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    let restTime = 11.0
    let workoutTime = 30.0
    var index = 5
    let dataSource = WorkoutData()
    var workouts: [Workout]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.delegate = self
        timerLabel.timerType = MZTimerLabelTypeTimer
        timerLabel.setCountDownTime(10)
        timerLabel.timeFormat = "ss"
        timerLabel.resetTimerAfterFinish = true
        timerLabel.start()
        workouts = dataSource.getWorkOuts()
        workoutlabel.text = workouts[0].title
        self.navigationController?.navigationBar.barTintColor = workouts[0].color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval) {
        if index & 0b1 == 0 {
            let wk = workouts[index / 2]
            timerLabel.text = "\(workoutTime)"
            mainLabel.text = wk.title
            self.view.backgroundColor = wk.color
            timerLabel.setCountDownTime(workoutTime)
            workoutlabel.text = wk.title
            self.navigationController?.navigationBar.barTintColor = wk.color
        } else {
            let wk = workouts[index / 2 + 1]
            timerLabel.text = "\(restTime)"
            mainLabel.text = wk.title
            self.view.backgroundColor = wk.color
            timerLabel.setCountDownTime(restTime)
            workoutlabel.text = "Take a Rest"
            self.navigationController?.navigationBar.barTintColor = wk.color
        }
        index += 1
        if !(index / 2 > workouts.count) {
            timerLabel.start()
        } else {
            print("Workout Done ! \n Nice Work !")
        }
    }
    
    
}
