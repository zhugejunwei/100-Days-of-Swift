//
//  UserTableViewCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/24/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class UserTableViewCell: UITableViewCell
{
    var user: User?
        {
        didSet {
            if let _ = user {
                headImgView.kf_setImage(with: URL(string: user!.headImg!)!, placeholder: UIImage(named: "pc_default_avatar"), options: [], progressBlock: nil, completionHandler: nil)
                userNameLabel.text = user!.userName
                mobileNumber.text = user!.mobile
                address.text = user!.address
                birthMonth.text = user?.birthMonth
                birthDay.text = user?.birthDay
            }
        }
    }

    // 点击购物车的回调
    var clickShopCar : (()->())?
    // 点击提示🔔的回调
    var clickRemind : (()->())?
    
    weak var parentViewController: UIViewController?
    
    static var g_self : UserTableViewCell?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }

    func setup() {
        contentView.addSubview(headImgView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(giftboxImg)
        contentView.addSubview(birthMonth)
        contentView.addSubview(birthDay)
        contentView.addSubview(mobileLabel)
        contentView.addSubview(mobileNumber)
        contentView.addSubview(addressLabel)
        contentView.addSubview(address)
        contentView.addSubview(shopCarBtn)
        contentView.addSubview(remindBtn)
        contentView.addSubview(mobileLine)
        contentView.addSubview(addressLine)
        
        headImgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(25)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headImgView).offset(5)
            make.left.equalTo(headImgView.snp.right).offset(10)
            make.width.lessThanOrEqualTo(250)
        }
        remindBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(userNameLabel)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        shopCarBtn.snp.makeConstraints { (make) in
            make.right.equalTo(remindBtn.snp.left).offset(-5)
            make.size.top.equalTo(remindBtn)
        }
        giftboxImg.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        birthMonth.snp.makeConstraints { (make) in
            make.left.equalTo(giftboxImg.snp.right).offset(10)
            make.top.equalTo(userNameLabel.snp.bottom).offset(15)
            make.right.equalTo(shopCarBtn.snp.left).offset(15)
        }
        birthDay.snp.makeConstraints { (make) in
            make.left.equalTo(birthMonth.snp.right).offset(5)
            make.top.equalTo(userNameLabel.snp.bottom).offset(15)
            make.right.equalTo(shopCarBtn.snp.left).offset(15)
        }
        mobileLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImgView)
            make.top.equalTo(headImgView.snp.bottom).offset(20)
            make.height.equalTo(15)
        }
        mobileLine.snp.makeConstraints { (make) in
            make.left.equalTo(mobileLabel.snp.right).offset(10)
            make.bottom.top.equalTo(mobileLabel)
            make.width.equalTo(1)
        }
        mobileNumber.snp.makeConstraints { (make) in
            make.left.equalTo(mobileLine.snp.right).offset(10)
            make.centerY.equalTo(mobileLine)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mobileLabel)
            make.top.equalTo(mobileLabel.snp.bottom).offset(10)
            make.height.equalTo(mobileLabel)
        }
        addressLine.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel.snp.right).offset(10)
            make.top.equalTo(addressLabel)
            make.height.equalTo(mobileLabel)
            make.width.equalTo(1)
        }
        address.snp.makeConstraints { (make) in
            make.left.equalTo(addressLine.snp.right).offset(10)
            make.centerY.equalTo(addressLine)
        }
    }
    
    // MARK: - lazy vars
    // user name and photo
    fileprivate lazy var headImgView: UIImageView = {
        let headimage = UIImageView()
        headimage.image = UIImage(named: "user_default")
        headimage.layer.cornerRadius = 15
        headimage.layer.masksToBounds = true
        headimage.layer.borderWidth = 0.5
        headimage.layer.borderColor = UIColor.lightGray.cgColor
        headimage.isUserInteractionEnabled = true
        headimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UserTableViewCell.clickHeadImage)))
        return headimage
    }()
    fileprivate lazy var userNameLabel: UILabel = {
        let userName = UILabel()
        userName.font = UIFont.init(name: "CODE LIGHT", size: 15.0)
        userName.text = "诸葛俊伟";
        return userName
    }()
    
    // gift box img
    fileprivate lazy var giftboxImg: UIImageView = {
        let gift = UIImageView()
        gift.image = UIImage(named: "giftbox")
        gift.isUserInteractionEnabled = false
        return gift
    }()
    
    // birthday and birthMonth
    fileprivate lazy var birthMonth = UILabel(textColor: UIColor.lightGray, font: UIFont.init(name: "CODE LIGHT", size: 11)!)
    fileprivate lazy var birthDay = UILabel(textColor: UIColor.lightGray, font: UIFont.init(name: "CODE LIGHT", size: 11)!)
    
    // mobile label and number
    fileprivate lazy var mobileLabel: UILabel = {
        let mobile = UILabel()
        let label = UILabel(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 11))
        label.text = "Mobile"
        return mobile
    }()
    fileprivate lazy var mobileNumber = UILabel(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 11))
    
    // address label and value
    fileprivate lazy var addressLabel: UILabel = {
        let address = UILabel()
        let label = UILabel(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 11))
        label.text = "Address"
        return address
    }()
    fileprivate lazy var address = UILabel(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 11))
    
    // cart btn and remind btn
    fileprivate lazy var shopCarBtn = UIButton(title: nil, imageName: "shoppingCar_35x35", target:g_self! , selector: #selector(UserTableViewCell.clickCar), font: nil, titleColor: nil)
    fileprivate lazy var remindBtn: UIButton = {
        let remindBtn = UIButton(type: .custom)
        
        return remindBtn
    }()
    
    // two breakers
    fileprivate lazy var mobileLine = UIImageView(image: UIImage(named: "f_loginfo_line_0x61"))
    fileprivate lazy var addressLine = UIImageView(image: UIImage(named: "f_loginfo_line_0x61"))
    
    // MARK: - cart and remind btn click method
    
    func clickCar() {
        if let _ = clickShopCar {
            clickShopCar!()
        }
    }
    func clickRemindBtn() {
        if let _ = clickRemind {
            clickRemind!()
        }
    }

    func clickHeadImage() {
        guard let _ = user else{
            return
        }
        parentViewController?.present(ImageBrowserViewController(urls: [URL(string: user!.headImg!)!], index: IndexPath(item: 0, section: 0)), animated: true, completion: nil)
    }
}
