//
//  MealModel.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/6/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class Meal {

    var mealImage: UIImage?
    var cnName: String
    var enName: String
    
    init(mealImage: UIImage?, cnName: String, enName: String) {
        self.mealImage = mealImage
        self.cnName = cnName
        self.enName = enName
    }
}

