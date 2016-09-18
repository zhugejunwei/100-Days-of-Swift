//
//  ProfileViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/10/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var saySomething: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var mobileNum: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var addressDetail: UILabel!
    @IBOutlet weak var profileShoppingCar: UIImageView!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var profile: Profile?
    var history: History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profile {
            profileImage.image = profile.profileImage
            profileName.text = profile.firstName + profile.lastName
            saySomething.text = profile.saySomething
            mobileLabel.text = profile.mobileLabel
            mobileNum.text = String(profile.mobileNum)
            addressLabel.text = profile.addressDetail
            campus.text = profile.campus
            addressDetail.text = profile.addressDetail
            profileShoppingCar.image = profile.profileShoppingCar
            }
        
        setRoundPhoto()
        
//        if let history = history {
//            
//        }
        
        loadSampleHistory()
    }
    
    // 设置头像图片为圆角图片，并添加边框
    fileprivate func setRoundPhoto() {
        self.profileImage.layer.cornerRadius = 10.0
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1.0
        self.profileImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    fileprivate func loadSampleHistory() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
