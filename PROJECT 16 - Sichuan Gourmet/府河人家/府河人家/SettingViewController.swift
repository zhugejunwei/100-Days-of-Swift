//
//  SettingViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.


import UIKit

class SettingViewController: UITableViewController, UIGestureRecognizerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        
         // 全屏右滑退出
        let target = self.navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    fileprivate func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer,
                                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer:
        UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
