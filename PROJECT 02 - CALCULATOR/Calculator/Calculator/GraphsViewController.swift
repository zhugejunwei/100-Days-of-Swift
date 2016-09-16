//
//  GraphsViewController.swift
//  Calculator
//
//  Created by 诸葛俊伟 on 5/20/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController
{
    fileprivate struct Storyboard {
        static let DrawGraph = "Draw Graph"
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == Storyboard.DrawGraph {
//            if let graphvc = segue.destinationViewController.contentViewController as? GraphsViewController {
//                
//                // draw graphs
//                
//            }
//        }
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        splitViewController?.delegate = self
//
//    }
    
}

//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool
//    {
//        if primaryViewController.contentViewController == self {
//            if let ivc = secondaryViewController.contentViewController as? GraphsViewController where ivc.content == nil
//        }
//    }

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
