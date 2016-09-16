//
//  Workout.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/14/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class Workout {
    var videoId: String!
    var title: String!
    var workoutText: String!
    var color: UIColor!
    
    init(videoId: String, title: String, workoutText: String, color: UIColor) {
        self.videoId = videoId
        self.title = title
        self.workoutText = workoutText
        self.color = color
    }
}
