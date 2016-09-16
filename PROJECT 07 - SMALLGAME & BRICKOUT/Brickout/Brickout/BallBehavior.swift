//
//  BallBehavior.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/19/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class BallBehavior: UIDynamicBehavior
{
    var gravity = UIGravityBehavior()
    fileprivate let collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    
    fileprivate let itemBehavior: UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 1.0
        return dib
    }()

    func addBarrier(_ path: UIBezierPath, named name: Int) {
        collider.removeBoundary(withIdentifier: name as NSCopying)
        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
    }
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    
    func addBoard(_ item: UIDynamicItem) {
        collider.addItem(item)
    }
    
    func addItem(_ item: UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
