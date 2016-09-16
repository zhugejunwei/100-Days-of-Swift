//
//  NamedBezierPathViews.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class NamedBezierPathViews: UIView
{
    var bezierPath = [Int:UIBezierPath]() { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        for (int, path) in bezierPath {
            if int == 36 {
                UIColor.red.setFill()
                path.fill()
                UIColor.cyan.setStroke()
                path.stroke()
            } else {
                UIColor.random.setFill()
                path.fill()
                UIColor.darkGray.setStroke()
                path.stroke()
            }
        }
    }
    
}
