//
//  LoginHelper.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

// the Key of login status
fileprivate let LoginStatus = "LoginStatus"

class LoginHelper: NSObject {
    // One line implement singleton
    static let sharedInstance = LoginHelper()
    // prevent inited by ()
    fileprivate override init() {}
    
    /// 一般情况下, 我们可以通过NSHTTPCookieStorage中的NSHTTPCookie来判断登录状态.也可以自定义一个字段来保存.这儿就简单一点了.
    
    // get the login status
    func isLogin() -> Bool {
        if let status: Bool = UserDefaults.standard.object(forKey: LoginStatus) as? Bool {
            return status
        }
        return false
    }
    
    // store the user login status
    func setLoginStatus(_ status: Bool) {
        UserDefaults.standard.set(status, forKey: LoginStatus)
    }
}
