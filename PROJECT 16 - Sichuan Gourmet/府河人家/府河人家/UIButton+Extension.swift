//
//  UIButton+Extension.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/24/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

extension UIButton
{
    convenience init(title: String?, imageName: String?, target: AnyObject? ,selector: Selector?, font: UIFont?, titleColor: UIColor?) {
        self.init()
        if let imageN = imageName {
            setImage(UIImage(named:imageN), for: UIControlState())
        }
        setTitleColor(titleColor, for: UIControlState())
        titleLabel?.font = font
        setTitle(title, for: UIControlState())
        if let sel = selector {
            addTarget(target, action: sel, for: .touchUpInside)
        }
        
    }
}
