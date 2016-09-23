//
//  LoginHeaderView.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

@objc
protocol LoginHeaderViewDelegate : NSObjectProtocol {
    // click register button
    @objc optional func loginHeaderView(_ loginHeaderView : LoginHeaderView, clickRegister registerbtn: UIButton)
    // click login button
    @objc optional func loginHeaderView(_ loginHeaderView : LoginHeaderView, clickDoneWithProfile profile: LoginProfile?)
}

class LoginHeaderView: UIView {
    weak var delegate : LoginHeaderViewDelegate?
    
    
}
