//
//  ProfileTableViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    fileprivate let UserCellIdentifier = "UserTableCell"
    fileprivate let HistoryCellIdentifier = "HistoryTableCell"
    private let UserHeaderReuseIdentifier = "UserHeaderReuseIdentifier"
    
    fileprivate var user: User?
    fileprivate var food : [Food]?
    
    init() {
        super.init(collectionViewLayout: CollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // sample user
        getUser()
        
        // sample food
        getFoodList()
    }
    
    deinit
    {
        ALinLog("deinit...")
    }
    
    fileprivate func setup()
    {
        collectionView?.backgroundColor = UIColor.init(gray: 241.0)
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCellIdentifier)
        collectionView?.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCellIdentifier)
        collectionView?.register(UINib.init(nibName: "UserHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: UserHeaderReuseIdentifier)
        
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pc_setting_40x40"), style: .plain, target: self, action: #selector(ProfileViewController.gotoSetting))
    }
    
    fileprivate func getUser() {
        var u = [String:Any]()
        u["id"] = "1"
        u["address"] = "Hillman Library"
        u["birthDay"] = "03"
        u["birthMonth"] = "Feb"
        u["campus"] = "Pitt"
        u["headImg"] = "user_default"
        u["mobile"] = "4127362858"
        u["userName"] = "Jay Z"
        self.user = User(dict:u)
    }
    
    fileprivate func getFoodList() {
        // use a sample list 
        var f = [Food]()
        for i in 0..<10 {
            var dict = [String:Any]()
            dict["foodImgName"] = "goodicon_\(i)"
            dict["meatName"] = "超好吃的\(i + 1)号大肉"
            dict["soupName"] = "美滋滋的\(i + 1)号菜汤"
            dict["originPrice"] = "8"
            dict["vipPrice"] = "6.8"
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return food?.count ?? 0
        } else {
            return 1
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCellIdentifier, for: indexPath) as! UserCollectionViewCell
            cell.user = user
            cell.clickShopCar = {
                ALinLog("点击了购物车")
            }
            cell.clickRemind = {
                ALinLog("点击了Remind")
            }
            cell.parentViewController = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCellIdentifier, for: indexPath) as! HistoryCollectionViewCell
        let count = food?.count ?? 0
        if count > 0 {
            cell.hisFood = food![indexPath.item]
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var header : UICollectionReusableView?
        header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserHeaderReuseIdentifier, for: indexPath)
        return header!
    }
    
    // MARK: - UICollectionView Delegate
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
    
    // MAKR: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == 0 {
            return CGSize(width: SCREEN_WIDTH
                , height: 160);
        }else{
            return CGSize(width: SCREEN_WIDTH, height: 80);
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        if section == 0 {
            return CGSize.zero
        }
        return CGSize(width: SCREEN_WIDTH
            , height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if section == 0 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
}

class CollectionViewFlowLayout: LevitateHeaderFlowLayout {
    override func prepare() {
        super.prepare()
        
        collectionView?.alwaysBounceVertical = true
        scrollDirection = .vertical
        minimumLineSpacing = 5
        minimumInteritemSpacing = 0
    }
}
