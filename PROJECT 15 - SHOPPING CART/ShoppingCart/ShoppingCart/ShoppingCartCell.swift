//
//  ShoppingCartCell.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/20/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
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
    var goodModel: GoodModel? {
        didSet {
            
            selectButton.isSelected = goodModel!.selected
            goodCountLabel.text = "\(goodModel!.count)"
            
            if let iconName = goodModel?.iconName {
                iconView.image = UIImage(named: iconName)
            }
            
            if let title = goodModel?.title {
                titleLabel.text = title
            }
            
            if let newPrice = goodModel?.newPrice {
                newPriceLabel.text = newPrice
            }
            
            if let oldPrice = goodModel?.oldPrice {
                oldPriceLabel.text = oldPrice
            }
            
            // 重新布局，会更新frame
            layoutIfNeeded()
        }
    }
    
    weak var delegate: ShoppingCartCellDelegate?
    
    // MARK: - 构造方法
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备UI
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        // 添加子控件
        contentView.addSubview(selectButton)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(newPriceLabel)
        contentView.addSubview(oldPriceLabel)
        contentView.addSubview(addAndsubtraction)
        addAndsubtraction.addSubview(subtractionButton)
        addAndsubtraction.addSubview(goodCountLabel)
        addAndsubtraction.addSubview(addButton)
        
        // 约束子控件
        selectButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        iconView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(42)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(12)
        }
        
        newPriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.top).offset(5)
            make.right.equalTo(-12)
        }
        
        oldPriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(newPriceLabel.snp.bottom).offset(5)
            make.right.equalTo(-12)
        }
        
        addAndsubtraction.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(120)
            make.top.equalTo(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        subtractionButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        goodCountLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(30)
            make.top.equalTo(0)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(70)
            make.top.equalTo(0)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 响应事件
    /**
     被点击的按钮，tag10 减   tag11 加
     
     - parameter button: 按钮
     */
    @objc fileprivate func didSelectedButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        goodModel?.selected = button.isSelected
        delegate?.reCalculateTotalPrice()
    }
    
    @objc fileprivate func didTappedCalculateButton(_ button: UIButton) {
        delegate?.shoppingCartCell(self, button: button, countLabel: goodCountLabel)
    }
    
    // MARK: - 懒加载
    
    fileprivate lazy var selectButton: UIButton = {
        let selectButton = UIButton(type: UIButtonType.custom)
        selectButton.setImage(UIImage(named: "check_n"), for: UIControlState())
        selectButton.setImage(UIImage(named: "check_y"), for: UIControlState.selected)
        selectButton.addTarget(self, action: #selector(ShoppingCartCell.didSelectedButton(_:)), for: UIControlEvents.touchUpInside)
        selectButton.sizeToFit()
        return selectButton
    }()
    
    fileprivate lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    fileprivate lazy var newPriceLabel: UILabel = {
        let newPriceLabel = UILabel()
        newPriceLabel.textColor = UIColor.red
        return newPriceLabel
    }()
    
    fileprivate lazy var oldPriceLabel: OldPriceLabel = {
        let oldPriceLabel = OldPriceLabel()
        oldPriceLabel.textColor = UIColor.gray
        return oldPriceLabel
    }()
    
    fileprivate lazy var goodCountLabel: UILabel = {
       let goodCountLabel = UILabel()
        goodCountLabel.textAlignment = .center
        return goodCountLabel
    }()
    
    fileprivate lazy var addAndsubtraction: UIView = {
       let addAndsubtraction = UIView()
        addAndsubtraction.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return addAndsubtraction
    }()
    
    fileprivate lazy var subtractionButton: UIButton = {
        let subtractionButton = UIButton(type: .custom)
        subtractionButton.tag = 10
        subtractionButton.setBackgroundImage(UIImage(named: "subtraction_icon"), for: UIControlState())
        subtractionButton.addTarget(self, action: #selector(ShoppingCartCell.didTappedCalculateButton(_:)), for: .touchUpInside)
        return subtractionButton
    }()
    
    fileprivate lazy var addButton: UIButton = {
        let addButton = UIButton(type: .custom)
        addButton.tag = 11
        addButton.setBackgroundImage(UIImage(named: "add_icon"), for: UIControlState())
        addButton.addTarget(self, action: #selector(ShoppingCartCell.didTappedCalculateButton(_:)), for: .touchUpInside)
        return addButton
    }()
}
