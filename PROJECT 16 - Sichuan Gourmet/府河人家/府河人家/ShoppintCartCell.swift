//
//  ShoppintCartCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/23/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

protocol ShoppingCartCellDelegate: NSObjectProtocol {
    func shoppingCartCell(_ cell: ShoppingCartCell, button: UIButton, countLabel: UILabel)
    func reCalculateTotalPrice()
}

class ShoppingCartCell: UITableViewCell
{
    // MARK: - Property
    
    var food: Food?
        {
        didSet {
            selectButton.isSelected = food!.selected
            foodCountLabel.text = "\(food!.count)"
            
            if let foodImageName = food?.foodImgName {
                foodImageView.image = UIImage(named: foodImageName)
            }
            if let meatName = food?.meatName {
                meatLabel.text = meatName
            }
            if let vipPrice = food?.vipPrice {
                vipPriceLabel.text = vipPrice
            }
            if let originPrice = food?.originPrice {
                originPriceLabel.text = originPrice
            }
            
            layoutIfNeeded()
        }
    }

    weak var delegate: ShoppingCartCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }
    
    fileprivate func prepareUI()
    {
        contentView.addSubview(selectButton)
        contentView.addSubview(foodImageView)
        contentView.addSubview(meatLabel)
        contentView.addSubview(vipPriceLabel)
        contentView.addSubview(originPriceLabel)
        contentView.addSubview(addAndSubtraction)
        addAndSubtraction.addSubview(subtractionButton)
        addAndSubtraction.addSubview(foodCountLabel)
        addAndSubtraction.addSubview(addButton)
        
        // constraints
        selectButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        foodImageView.snp.makeConstraints { (make) in
            make.left.equalTo(42)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        meatLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(foodImageView.snp.right).offset(12)
        }
        vipPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(meatLabel.snp.top).offset(5)
            make.right.equalTo(-12)
        }
        originPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(vipPriceLabel.snp.bottom).offset(5)
            make.right.equalTo(-12)
        }
        addAndSubtraction.snp.makeConstraints { (make) in
            make.left.equalTo(120)
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        subtractionButton.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        foodCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(0)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        addButton.snp.makeConstraints { (make) in
            make.left.equalTo(70)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - Click Events
    /**
     被点击的按钮，tag10 减   tag11 加
     
     - parameter button: 按钮
     */
    @objc fileprivate func didSelectedButton(_ btn: UIButton) {
        btn.isSelected = !btn.isSelected
        food?.selected = btn.isSelected
        delegate?.reCalculateTotalPrice()
    }
    
    @objc fileprivate func didTappedCalculateButton(_ btn: UIButton) {
        delegate?.shoppingCartCell(self, button: btn, countLabel: foodCountLabel)
    }
    
    // MARK: - lazy vars
    
    fileprivate lazy var selectButton: UIButton = {
       let select = UIButton(type: .custom)
        select.setImage(UIImage(named: "check_n"), for: UIControlState())
        select.setImage(UIImage(named: "check_y"), for: UIControlState.selected)
        select.addTarget(self, action: #selector(didSelectedButton(_:)), for: .touchUpInside)
        select.sizeToFit()
        return select
    }()
    
    fileprivate lazy var foodCountLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var foodImageView: UIImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    fileprivate lazy var meatLabel: UILabel = {
        let meat = UILabel()
        return meat
    }()
    
    fileprivate lazy var vipPriceLabel: UILabel = {
        let vip = UILabel()
        vip.textColor = UIColor.red
        return vip
    }()
    
    fileprivate lazy var originPriceLabel: OriginPriceLabel = {
        let origin = OriginPriceLabel()
        origin.textColor = UIColor.gray
        return origin
    }()
    
    fileprivate lazy var addAndSubtraction: UIView = {
        let addAndSub = UIView()
        addAndSub.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return addAndSub
    }()
    
    fileprivate lazy var subtractionButton: UIButton = {
        let sub = UIButton(type: .custom)
        sub.tag = 10
        sub.setBackgroundImage(UIImage(named: "subtraction_icon"), for: UIControlState())
        sub.addTarget(self, action: #selector(ShoppingCartCell.didTappedCalculateButton(_:)), for: .touchUpInside)
        return sub
    }()
    
    fileprivate lazy var addButton: UIButton = {
        let add = UIButton(type: .custom)
        add.tag = 11
        add.setBackgroundImage(UIImage(named: "add_icon"), for: UIControlState())
        add.addTarget(self, action: #selector(ShoppingCartCell.didTappedCalculateButton(_:)), for: .touchUpInside)
        return add
    }()
}
