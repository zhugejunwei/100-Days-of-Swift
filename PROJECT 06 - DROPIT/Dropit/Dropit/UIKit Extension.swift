//
//  File.swift
//  Dropit
//
//  Created by 诸葛俊伟 on 6/16/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.lightGrayColor()
        case 3: return UIColor.orangeColor()
        case 4: return UIColor.yellowColor()
        default: return UIColor.redColor()
        }
    }
}

extension CGRect {
    var mid: CGPoint { return CGPoint(x: midX, y: midY) }
    var upperLeft: CGPoint { return CGPoint(x: minX, y: minY) }
    var lowerLeft: CGPoint { return CGPoint(x: minX, y: maxY) }
    var upperright: CGPoint { return CGPoint(x: maxX, y: minY) }
    var lowerright: CGPoint { return CGPoint(x: maxX, y: maxY) }

    init(center: CGPoint, size: CGSize) {
        let upperLeft = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        self.init(origin: upperLeft, size: size)
    }
}

extension UIView {
    func hitTest(p: CGPoint) -> UIView? {
        return hitTest(p, withEvent: nil)
    }
}

extension UIBezierPath {
    class func lineFrom(from: CGPoint, to: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(from)
        path.addLineToPoint(to)
        return path
    }
}