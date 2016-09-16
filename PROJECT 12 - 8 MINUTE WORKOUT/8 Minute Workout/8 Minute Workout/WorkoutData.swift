//
//  WorkoutDataSource.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/14/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit
import ChameleonFramework

class WorkoutData
{
    var workouts:[Workout]
    
    init() {
        workouts = []
        let wk1 = Workout(videoId: "UpH7rm0cYbM", title: "Jumping Jacks", workoutText: "A calisthenic jump done from a standing position with legs together and arms at the sides to a position with the legs apart and the arms over the head.",color:  UIColor.flatRed())
        workouts.append(wk1)
        
        let wk2 = Workout(videoId: "y-wV4Venusw", title: "Wall Sits", workoutText: "A wall sit, also known as a Roman Chair, is an exercise done to strengthen the quadriceps muscles. It is characterized by the two right angles formed by the body, one at the hips and one at the knees.", color: UIColor.flatTeal())
        workouts.append(wk2)
        
        
        let wk4 = Workout(videoId: "2yOFvV-NSeY", title: "Abdominal Crunches", workoutText: "A crunch begins with lying face up on the floor with knees bent. The movement begins by curling the shoulders towards the pelvis. The hands can be behind or beside the neck or crossed over the chest. Injury can be caused by pushing against the head or neck with hands.", color: UIColor.flatPurple())
        workouts.append(wk4)
        
        let wk3 = Workout(videoId: "Eh00_rniF8E", title: "Push Ups", workoutText: "An exercise in which a person lies facing the floor and, keeping their back straight, raises their body by pressing down on their hands.", color: UIColor.flatBlue())
        workouts.append(wk3)
        
        
        let wk5 = Workout(videoId: "kM2FfDIwsao", title: "Step-ups onto a chair", workoutText: "To do a step-up, position your chair in front of your body. Stand with your feet about hip-width apart, arms at your sides. Step up onto the seat with one foot, pressing down while bringing your other foot up next to it. ", color: UIColor.flatGreen())
        workouts.append(wk5)
        
        let wk6 = Workout(videoId: "mGvzVjuY8SY", title: "Squats", workoutText: "Crouch or sit with one's knees bent and one's heels close to or touching one's buttocks or the back of one's thighs.", color: UIColor.flatNavyBlue())
        workouts.append(wk6)
        
        let wk7 = Workout(videoId: "0326dy_-CzM", title: "Triceps dips on a chair", workoutText: "Triceps dips on a chair", color: UIColor.flatWatermelon())
        workouts.append(wk7)
    }
    
    func getWorkOuts() -> [Workout] {
        return workouts
    }
    
}
