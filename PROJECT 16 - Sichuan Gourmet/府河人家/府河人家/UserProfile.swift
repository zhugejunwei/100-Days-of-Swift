//
//  UserProfile.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class UserProfile: NSObject
{
    
    var userName: String?
    
    var headImg: UIImage?
    
    var mobile: String?
    
    var campus: String?
    
    var address: String?
    
    var birthMonth: String?
    
    var birthDay: String?
    
    init(dict: [String:Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

