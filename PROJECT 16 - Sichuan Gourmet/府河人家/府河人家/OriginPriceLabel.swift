//
//  OriginPriceLabel.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/23/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class OriginPriceLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: 0, y: rect.size.height * 0.5))
        ctx?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height * 0.5))
        ctx?.strokePath()
    }
}
