//
//  MenuTableViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class MenuViewController: UIViewController
{
    // MARK: - Property
    
    var food: [Food]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /**
         提醒：
         这是 view 即将呈现出来之前的方法，一般把需要大量运算的程序放在这里（比如多线程的操作），view 的 geometry 也是在这里设置的，但是如果要做旋转之类的操作，其它地方会响应这些操作。具体请见（http://www.jianshu.com/p/5e784091dae3）。
         */
        
        layoutUI()
    }

    fileprivate func prepareUI() {
        
    }
    
    fileprivate func layoutUI() {
        
    }
}
