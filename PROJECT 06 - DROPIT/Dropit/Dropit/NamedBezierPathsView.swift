//
//  NamedBezierPathsView.swift
//  Dropit
//
//  Created by 诸葛俊伟 on 6/16/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class NamedBezierPathsView: UIView
{
    var bezierPaths = [String:UIBezierPath]() { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
    
}
