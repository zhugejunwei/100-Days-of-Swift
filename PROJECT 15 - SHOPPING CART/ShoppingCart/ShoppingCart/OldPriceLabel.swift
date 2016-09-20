//
//  OldPriceLabel.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/20/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
//

import UIKit

class OldPriceLabel: UILabel {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 绘制中划线
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: 0, y: rect.size.height * 0.5))
        ctx?.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height * 0.5))
        ctx?.strokePath()
    }
}
