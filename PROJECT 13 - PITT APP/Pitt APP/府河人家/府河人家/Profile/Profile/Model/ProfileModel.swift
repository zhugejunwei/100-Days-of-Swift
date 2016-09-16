//
//  ProfileModel.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/10/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class Profile {
    var profileImage: UIImage?
    var firstName: String
    var lastName: String
    var saySomething: String
    var mobileLabel: String
    var mobileNum: Int
    var addressLabel: String
    var campus: String
    var addressDetail: String
    var profileShoppingCar: UIImage?
    
    init(profileImage: UIImage?, firstName: String, lastName: String, saySomething: String, mobileLabel: String, mobileNum: Int, addressLabel: String, campus: String, address: String, profileShoppingCar: UIImage?) {
        self.profileImage = profileImage
        self.firstName = firstName
        self.lastName = lastName
        self.saySomething = saySomething
        self.mobileLabel = mobileLabel
        self.mobileNum = mobileNum
        self.addressLabel = addressLabel
        self.addressDetail = address
        self.campus = campus
        self.profileShoppingCar = profileShoppingCar
    }
}
