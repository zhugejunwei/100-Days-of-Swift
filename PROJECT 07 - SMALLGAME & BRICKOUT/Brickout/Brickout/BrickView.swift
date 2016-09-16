//
//  BrickView.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit
import CoreMotion

@IBDesignable
class BrickView: NamedBezierPathViews, UIDynamicAnimatorDelegate
{
    fileprivate var boardSize: CGSize {
        let width = bounds.size.width / 4
        let height = width / 8
        return CGSize(width: width, height: height)
    }
    
    fileprivate var ballSize: CGSize {
        let width = boardSize.height
        let height = width
        return CGSize(width: width, height: height)
    }
    
    fileprivate lazy var animator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        return animator
    }()
    
    fileprivate let ballBehavior = BallBehavior()
    
    var animating = false {
        didSet {
            if animating {
                animator.addBehavior(ballBehavior)
//                updateRealGravity()
            } else {
                animator.removeBehavior(ballBehavior)
            }
        }
    }
    
    fileprivate var attachment: UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
            }
        }
    }
    
//    var realGravity: Bool = false {
//        didSet {
//            updateRealGravity()
//        }
//    }
    
    fileprivate let motionManager = CMMotionManager()
    
//    func updateRealGravity() {
//        if realGravity {
//            if motionManager.accelerometerAvailable && !motionManager.accelerometerActive {
//                motionManager.accelerometerUpdateInterval = 0.25
//                motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue())
//                { (data, error) in
//                    if self.ballBehavior.dynamicAnimator != nil {
//                        if var dx = data?.acceleration.x, var dy = data?.acceleration.y {
//                            switch UIDevice.currentDevice().orientation {
//                            case .Portrait: dy = -dy
//                            case .PortraitUpsideDown: break
//                            case .LandscapeRight: swap(&dx, &dy)
//                            case .LandscapeLeft: swap(&dx, &dy); dy = -dy
//                            default: dx = 0; dy = 0;
//                            }
//                            self.ballBehavior.gravity.gravityDirection = CGVector(dx: dx, dy: dy)
//                        }
//                    } else {
//                        self.motionManager.stopAccelerometerUpdates()
//                    }
//                }
//            }
//        } else {
//            motionManager.stopAccelerometerUpdates()
//        }
//    }
    
    fileprivate let bricksPerRow = 6
    fileprivate var brickSize: CGSize {
        let width = bounds.size.width / CGFloat(bricksPerRow)
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    
    var brickArray = [Array<Int>]()
    
    // Append Bricks to brickArray, Int from 0...35, 6 rows, 6 columns.
    func appendBrickArray() -> [Array<Int>]
    {
        for column in 0...5 {
            var columnArray = Array<Int>()
            for row in 6*column...6*column+5 {
                columnArray.append(row)
            }
            brickArray.append(columnArray)
        }
    return brickArray
    }
    
    struct PathInts {
        static let Brick = 0...35
        static let Barrier = 36
        static let Board = 50
        static let Ball = 51
    }
    
    func addBricks()
    {
        appendBrickArray()
        for rows in 0...5 {
            for bricks in 0...5 {
                let startPoint = CGPoint(x: CGPoint.zero.x + CGFloat(bricks) * brickSize.width, y: CGPoint.zero.y + CGFloat(rows) * brickSize.height)
                let brickPath = UIBezierPath(rect: CGRect(origin: startPoint, size: brickSize))
                ballBehavior.addBarrier(brickPath, named: brickArray[rows][bricks])
                bezierPath[brickArray[rows][bricks]] = brickPath
            }
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        addBricks()
        
        let barrierPath = UIBezierPath(ovalIn: CGRect(center: CGPoint(x: bounds.mid.x, y: 10 * brickSize.height), size: brickSize))
        ballBehavior.addBarrier(barrierPath, named: PathInts.Barrier)
        bezierPath[PathInts.Barrier] = barrierPath
    }
    
    fileprivate var movedBall: UIView?
    
    func addBall()
    {
        var frame = CGRect(origin: CGPoint.zero, size: ballSize)
        frame.origin.x = bounds.mid.x + boardSize.width / 2
        frame.origin.y = bounds.size.height - boardSize.height - boardSize.height
        
        let ball = UIView(frame: frame)
        ball.backgroundColor = UIColor.black
        ball.layer.cornerRadius = CGFloat(2 * M_PI)
        
        addSubview(ball)
        
        ballBehavior.addItem(ball)
        movedBall = ball
    }
    
    func startBall(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            pushBall([movedBall!])
        }
    }
    
    func pushBall(_ ball: [UIView]) {
        let push = UIPushBehavior(items: ball, mode: UIPushBehaviorMode.instantaneous)
        push.magnitude = 1.0
        push.pushDirection = CGVector(dx: 2, dy: -2)
        animator.removeBehavior(push)
        animator.addBehavior(push)
    }
    
    func addBoard()
    {
        var frame = CGRect(origin: CGPoint.zero, size: boardSize)
        frame.origin.x = bounds.mid.x
        frame.origin.y = bounds.size.height - boardSize.height
        
        let board = UIView(frame: frame)
        board.backgroundColor = UIColor.blue
        board.layer.cornerRadius = CGFloat(20)
        
        addSubview(board)
        
        ballBehavior.addBoard(board)
    }
    
//    func moveBoard(recognizer: UIPanGestureRecognizer) {
//        let gesturePoint = recognizer.locationInView(self)
//        switch recognizer.state {
//        case .Began:
//            // create attachment
//            if let boardToAttachTo = movedBoard where boardToAttachTo.superview != nil {
//                attachment = UIAttachmentBehavior(item: boardToAttachTo, attachedToAnchor: gesturePoint)
//            }
//        //            lastDrop = nil
//        case .Changed:
//            // create attachment's anchor point
//            attachment!.anchorPoint = gesturePoint
//        default:
//            attachment = nil
//        }
//        
//    }
}
