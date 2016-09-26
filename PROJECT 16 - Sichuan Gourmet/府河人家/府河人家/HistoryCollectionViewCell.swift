//
//  HistoryTableViewCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/24/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell
{
    var hisFood: Food? {
        didSet {
            if let foodImageName = hisFood?.foodImgName {
                foodImage.image = UIImage(named: foodImageName)
            }
            if let meatName = hisFood?.meatName {
                meatNameLabel.text = meatName
            }
            if let soupName = hisFood?.soupName {
                soupNameLabel.text = soupName
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setup() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(foodImage)
        contentView.addSubview(meatNameLabel)
        contentView.addSubview(soupNameLabel)
        
        foodImage.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        meatNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(foodImage.snp.right).offset(12)
        }
        soupNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meatNameLabel.snp.bottom).offset(12)
            make.left.equalTo(foodImage.snp.right).offset(12)
        }
    }
    
    // MARK: - lazy vars
    fileprivate lazy var foodImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()

    fileprivate lazy var meatNameLabel = UILabel(textColor: UIColor.black, font: UIFont.systemFont(ofSize: 16))
    
    fileprivate lazy var soupNameLabel = UILabel(textColor: UIColor.lightGray, font: UIFont.systemFont(ofSize: 13))
}
