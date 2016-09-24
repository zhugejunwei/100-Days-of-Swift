//
//  MenuListCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuListCellDelegate: NSObjectProtocol {
    func menuListCell(_ cell: MenuListCell, foodImageView: UIImageView)
}

class MenuListCell: UITableViewCell
{
    // MARK: - Property
    
    var food: Food?
        {
        didSet {
            if let foodImgName = food?.foodImgName {
                foodImageView.image = UIImage(named: foodImgName)
            }
            if let meatName = food?.meatName {
                meatLabel.text = meatName
            }
            if let soupName = food?.soupName {
                soupLabel.text = soupName
            }
            
            // To prevent reuse cell, disable the addCartBtn when clicked
            addCartBtn.isEnabled = !food!.alreadyInShoppingCart
            
            // relayout, refresh frame
            layoutIfNeeded()
        }
    }
    
    weak var delegate: MenuListCellDelegate?
    
    var callBackImageView: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    fileprivate func prepareUI()
    {
        // add subviews
        contentView.addSubview(foodImageView)
        contentView.addSubview(meatLabel)
        contentView.addSubview(soupLabel)
        contentView.addSubview(addCartBtn)
        
        // constraints
        foodImageView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        meatLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(foodImageView.snp.right).offset(12)
        }
        soupLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meatLabel.snp.bottom).offset(12)
            make.left.equalTo(foodImageView.snp.right).offset(12)
        }
        addCartBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.top.equalTo(25)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }

    // MARK: - lazy vars
    
    fileprivate lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate lazy var meatLabel: UILabel = {
        let meat = UILabel()
        return meat
    }()
    
    fileprivate lazy var soupLabel: UILabel = {
        let soup = UILabel()
        soup.textColor = UIColor.gray
        return soup
    }()
    
    fileprivate lazy var addCartBtn: UIButton = {
        let addCartBtn = UIButton(type: .custom)
        addCartBtn.setBackgroundImage(UIImage(named: "button_cart_add"), for: .normal)
        addCartBtn.setTitle("Buy", for: .normal)
        addCartBtn.tag = 1
        addCartBtn.addTarget(self, action: #selector(MenuListCell.didTappedCartBtn(_:)), for: .touchUpInside)
        return addCartBtn
    }()
    
    // MARK: - Event response
    
    // click addCartBtn
    @objc fileprivate func didTappedCartBtn(_ btn: UIButton)
    {
        food?.alreadyInShoppingCart = true
        
        if btn.tag == 1{
            btn.isEnabled = !food!.alreadyInShoppingCart
        }
        
        delegate?.menuListCell(self, foodImageView: foodImageView)
    }
    
}
