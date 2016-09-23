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
    func menuListCell(_ cell: MenuListCell, iconView: UIImageView)
}

class MenuListCell: UITableViewCell
{
    // MARK: - Property
    
    var food: Food? {
        didSet {
            if let foodImgName = Food?.foodImgName {
                imageView.image = UIImage(named: foodImgName)
            }
            if let meatName = Food?.meatName {
                meatLabel.text = meatName
            }
            if let soupName = Food?.soupName {
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
    
    override init(style: UITableViewCell, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        
    }
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate lazy var meatLabel: UILabel = {
        
    }()
    
    fileprivate lazy var soupLabel: UILabel = {
        
    }()
    
    fileprivate lazy var addCartBtn: UIButton = {
        
    }()
    
    // MARK: - Event response
    
    // click buy btn
    
    
}
