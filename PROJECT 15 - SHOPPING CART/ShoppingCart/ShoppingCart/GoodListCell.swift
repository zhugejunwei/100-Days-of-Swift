//
//  GoodListCell.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/19/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
//

import UIKit
import SnapKit

protocol GoodListCellDelegate: NSObjectProtocol {
    func goodListCell(_ cell: GoodListCell, iconView: UIImageView)
}

class GoodListCell: UITableViewCell
{
    // MARK: - Property
    var goodModel: GoodModel?
    {
        didSet {
            if let iconName = goodModel?.iconName {
                iconView.image = UIImage(named: iconName)
            }
            if let title = goodModel?.title {
                titleLabel.text = title
            }
            if let desc = goodModel?.desc {
                descLabel.text = desc
            }
            
            // 已经点击的就禁用,这样做是防止cell重用
            addCartBtn.isEnabled = !goodModel!.alreadyInShoppingCart
            
            // 重新布局，更新frame
            layoutIfNeeded()
        }
    }

    // 代理属性
    weak var delegate: GoodListCellDelegate?
    
    // 回调给控制器的商品图标
    var callBackIconView: UIImageView?
    
    // MARK: - 构造方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    fileprivate func prepareUI()
    {
        // 添加子控件
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(addCartBtn)
        
        // constraints
        iconView.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(12)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(iconView.snp.right).offset(12)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.equalTo(iconView.snp.right).offset(12)
        }
        
        addCartBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.top.equalTo(25)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 懒加载

    fileprivate lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.layer.cornerRadius = 30
        iconView.layer.masksToBounds = true
        return iconView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let title = UILabel()
        return title
    }()
    
    fileprivate lazy var descLabel: UILabel = {
        let des = UILabel()
        des.textColor = UIColor.gray
        return des
    }()
    
    fileprivate lazy var addCartBtn: UIButton = {
        let addCartBtn = UIButton(type: .custom)
        addCartBtn.setBackgroundImage(UIImage(named: "button_cart_add"), for: .normal)
        addCartBtn.setTitle("购买", for: .normal)
        addCartBtn.tag = 1
        addCartBtn.addTarget(self, action: #selector(GoodListCell.didTappedCartButton(_:)), for: .touchUpInside)
        return addCartBtn
    }()
    
    // MARK: - 事件响应
    
    // 点击购买按钮
    @objc fileprivate func didTappedCartButton(_ button: UIButton) {
        // 已经购买
        goodModel?.alreadyInShoppingCart = true
        
        // 已经点击的就禁用
        if button.tag == 1 {
            button.isEnabled = !goodModel!.alreadyInShoppingCart
        }
        
        // 通知代理对象，去处理后续操作
        delegate?.goodListCell(self, iconView: iconView)
    }
}
