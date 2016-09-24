//
//  ProfileTableViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

fileprivate let UserCellIdentifier = "UserTableCell"
fileprivate let HistoryCellIdentifier = "HistoryTableCell"

class ProfileTableViewController: UITableViewController
{
    var user: User? 

    var food: [Food]?
        {
        didSet {
            if let _ == food {
                tableView!.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getFoodList()
    }
    
    fileprivate func setup() {
        tableView?.backgroundColor = UIColor.init(gray: 241.0)
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pc_setting_40x40"), style: .plain, target: self, action: #selector(ProfileTableViewController.gotoSetting))
        
        tableView!.register(UserTableViewCell.self, forCellReuseIdentifier: UserCellIdentifier)
        tableView!.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryCellIdentifier)
    }
    
    fileprivate func getFoodList() {
        // use a sample list 
        var f = [Food]()
        for i in 0..<11 {
            var dict = [String:Any]()
            dict["foodImgName"] = "goodicon_\(i)"
            dict["meatName"] = "超好吃的\(i + 1)号大肉"
            dict["soupName"] = "美滋滋的\(i + 1)号菜汤"
            // 字典转模型并将模型添加到模型数组中
            f.append(Food(dict: dict))
        }
        self.food = f
    }
    
    @objc fileprivate func gotoSetting() {
        let setting = UIStoryboard.init(name: "SettingViewController", bundle: nil).instantiateInitialViewController()
        setting?.navigationItem.title = "Setting"
        navigationController?.pushViewController(setting!, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCellIdentifier, for: indexPath) as! UserTableViewCell
            cell.user = user
        }
    }
}
