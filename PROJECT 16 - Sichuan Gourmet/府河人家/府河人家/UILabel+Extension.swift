//
//  UILabel+Extension.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/24/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

extension UILabel
{
    convenience init(textColor: UIColor, font: UIFont) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}
