//
//  NavigationViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if childViewControllers.count > 0 {
        // when we push, hide the tab bar
        viewController.hidesBottomBarWhenPushed = true
        // add the BACK button
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(NavigationViewController.back))
        }
        super.pushViewController(viewController, animated: true)
    }

    func back() {
        popViewController(animated: true)
    }
}
