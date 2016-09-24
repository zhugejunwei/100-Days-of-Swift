//
//  MainViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    fileprivate func setup()
    {
        tabBar.tintColor = UIColor.black
        
        // a simple localization
        addViewController(GoodListViewController(), title: NSLocalizedString("tab_menu", comment: ""))
        addViewController(ProfileTableViewController(), title: NSLocalizedString("tab_profile", comment: ""))
    }

    
    // add child controller
    fileprivate func addViewController(_ childController: UIViewController, title: String) {
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
        childController.tabBarItem.selectedImage = UIImage(named: "tab_\(childViewControllers.count - 1)" + "_selected")
        
        childController.tabBarItem.tag = childViewControllers.count - 1
    }
    
    
    
    // When user click the Profile tab, if he has been logined, go to profile page; if not, go to login page.
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) -> Bool{
//        return true
//    }
    
    // LoginViewControllerDelegate
//    func loginViewControllerDidSuccess(_ loginViewController: LoginViewController) {
//        selectedIndex = childViewControllers.count - 1
//        dismiss(animated: true, completion: nil)
//    }
    
    // MARK: - private method: show login page
//    fileprivate func login() {
//        let loginVC = LoginViewController()
//        loginVC.delegate = self
//        let nav = NavigationViewController(rootViewController: loginVC)
//        // set the navigationBar background to be translucent
//        nav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        nav.navigationBar.shadowImage = UIImage()
//        nav.navigationBar.isTranslucent = true
//        
//        present(nav, animated: true, completion: nil)
//    }
    
}
