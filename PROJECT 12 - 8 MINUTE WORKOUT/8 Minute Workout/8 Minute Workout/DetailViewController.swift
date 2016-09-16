//
//  DetailViewController.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/14/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController
{
    @IBOutlet weak var detailText: UILabel!
    var workout: Workout!
    
    @IBOutlet weak var playerView: YTPlayerView!
    let playerVars = ["playsInLine":"1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerView.load(withPlaylistId: workout.videoId, playerVars: playerVars)
        self.view.backgroundColor = workout.color
        self.detailText.text = workout.workoutText
        self.title = workout.title
        self.navigationController?.navigationBar.barTintColor = workout.color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
