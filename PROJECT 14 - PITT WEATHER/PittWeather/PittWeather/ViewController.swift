//
//  ViewController.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/2/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 将建好的三个视图控制器的 view 贴到 ViewController 中
    
    var mainViewController: UIViewController?
    var leftViewController: LeftTableViewController?
    var rightViewController: RightTableViewController?
    
    // 滑动速率
    var slideSpeed: CGFloat?
    
    // 条件：什么时候显示左边，中间，右边的 view
    var condition: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slideSpeed = 1.0
        self.condition = 0

        let rootController = MainViewController()
        
        self.leftViewController = LeftTableViewController()
        self.view.addSubview((self.leftViewController?.view)!)
        
        self.rightViewController = RightTableViewController()
        self.view.addSubview((self.rightViewController?.view)!)
        
        self.mainViewController = UINavigationController(rootViewController: rootController)
        self.view.addSubview((self.mainViewController?.view)!)
        
        // 将左右两边的试图隐藏
        self.leftViewController?.view.hidden = true
        self.rightViewController?.view.hidden = true
        
        // 添加滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panAction(_:)))
        self.mainViewController?.view.addGestureRecognizer(pan)
    }
    
    func panAction(sender: UIPanGestureRecognizer) {
        
        // 获取屏幕手指的位置
        let point = sender.translationInView(sender.view)
        self.condition = point.x * 2.0 * self.slideSpeed! + self.condition!
        
        if sender.view?.frame.origin.x >= 0 {
            sender.view?.center = CGPointMake((sender.view?.center.x)! + point.x * self.slideSpeed!, (sender.view?.center.y)!)
            sender.setTranslation(CGPointMake(0, 0), inView: self.view)
            self.rightViewController?.view.hidden = true
            self.leftViewController?.view.hidden = false
        }else {
            sender.view?.center = CGPointMake((sender.view?.center.x)! + point.x * self.slideSpeed!, (sender.view?.center.y)!)
            sender.setTranslation(CGPointMake(0, 0), inView: self.view)
            self.rightViewController?.view.hidden = false
            self.leftViewController?.view.hidden = true
        }
        
        // 当手指离开屏幕时
        if sender.state == .Ended {
            if self.condition > UIScreen.mainScreen().bounds.width * 0.5 * self.slideSpeed! {
                self.showLeftView()
            }else if self.condition < UIScreen.mainScreen().bounds.width * (-0.5) * self.slideSpeed! {
                self.showRightView()
            }else {
                showMainView()
            }
        }
    }
    
    func showMainView() {
        
        UIView.beginAnimations(nil, context: nil)
        
        self.mainViewController?.view.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height/2)
        
        UIView.commitAnimations()
    }
    
    func showLeftView() {
        
        UIView.beginAnimations(nil, context: nil)
        
        self.mainViewController?.view.center = CGPointMake(UIScreen.mainScreen().bounds.size.width * 1.5 - 60, UIScreen.mainScreen().bounds.size.height/2)
        
        UIView.commitAnimations()
    }
    
    func showRightView() {
        
        UIView.beginAnimations(nil, context: nil)
        
        self.mainViewController?.view.center = CGPointMake(60 - UIScreen.mainScreen().bounds.size.width * 0.5, UIScreen.mainScreen().bounds.size.height/2)
        
        UIView.commitAnimations()
    }
    
    // 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

