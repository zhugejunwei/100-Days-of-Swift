//
//  LoginProfile.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class LoginProfile: NSObject {
    var mobile: String?
    
    var safeNum: String?
    
    var campus: String?
    
    var address: String?
    
    func isValidMobileNum(_ phone: String) -> Bool {
        let pattern = "^\\d+$"
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluate(with: phone)
    }
}
