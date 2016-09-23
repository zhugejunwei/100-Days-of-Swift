//
//  ShoppingCartViewController.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/20/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
//

import UIKit
import SnapKit

class ShoppingCartViewController: UIViewController
{
    // MARK: - Property
    
    var addGoodArray: [GoodModel]?
    // total price
    var price: Float = 0.0
    // Cell identifier
    fileprivate var shoppingCarCellIdentifier = "shoppingCarCell"
    
    // MARK: - View Lifecircle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutUI()
        
        reCalculateCount()
    }
    
    fileprivate func prepareUI() {
        navigationItem.title = "购物车"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ShoppingCartViewController.didTappedBackButton))
        view.backgroundColor = UIColor.white
        tableView.rowHeight = 80
        // 注册cell
        tableView.register(ShoppingCartCell.self, forCellReuseIdentifier: shoppingCarCellIdentifier)
        
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(selectButton)
        bottomView.addSubview(totalPriceLabel)
        bottomView.addSubview(buyButton)
    }
    
    fileprivate func layoutUI() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(-49)
        }
        
        bottomView.snp.makeConstraints { (make) -> Void in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(49)
        }
        
        selectButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(12)
            make.centerY.equalTo(bottomView.snp.centerY)
        }
        
        totalPriceLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(bottomView.snp.center)
        }
        
        buyButton.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-12)
            make.top.equalTo(9)
            make.width.equalTo(88)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - 懒加载
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var bottomView: UIView = {
       let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    lazy var selectButton: UIButton = {
        let selectBtn = UIButton(type: .custom)
        selectBtn.setImage(UIImage(named: "check_n"), for: UIControlState())
        selectBtn.setImage(UIImage(named: "check_y"), for: UIControlState())
        selectBtn.setTitle("多选\\反选", for: UIControlState())
        selectBtn.setTitleColor(UIColor.gray, for: UIControlState())
        selectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        selectBtn.addTarget(self, action: #selector(ShoppingCartViewController.didTappedSelectButton), for: .touchUpInside)
        selectBtn.isSelected = true
        selectBtn.sizeToFit()
        return selectBtn
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let tpl = UILabel()
        let attributeText = NSMutableAttributedString(string: "总价：\(self.price)0")
        attributeText.setAttributes([NSForegroundColorAttributeName:UIColor.red], range: NSMakeRange(5, attributeText.length - 5))
        tpl.attributedText = attributeText
        tpl.sizeToFit()
        return tpl
    }()
    
    lazy var buyButton: UIButton = {
        let buyBtn = UIButton(type: .custom)
        buyBtn.setTitle("Pay", for: UIControlState())
        buyBtn.setBackgroundImage(UIImage(named: "button_cart_add"), for: UIControlState())
        buyBtn.layer.cornerRadius = 15
        buyBtn.layer.masksToBounds = true
        return buyBtn
    }()
}

extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addGoodArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCarCellIdentifier, for: indexPath) as! ShoppingCartCell
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.goodModel = addGoodArray?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reCalculateCount()
    }
}

// MARK: - view 上的一些事件处理

extension ShoppingCartViewController {
    @objc fileprivate func didTappedBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func reCalculateCount() {
        for model in addGoodArray! {
            if model.selected == true {
                price += Float(model.count) * (model.newPrice! as NSString).floatValue
            }
        }
        
        // 赋值价格
        let attributeText = NSMutableAttributedString(string: "总共价格：\(self.price)0")
        attributeText.setAttributes([NSForegroundColorAttributeName : UIColor.red], range: NSMakeRange(5, attributeText.length - 5))
        totalPriceLabel.attributedText = attributeText
        
        price = 0
        
        tableView.reloadData()
    }
    
    /**
     点击了多选按钮后的事件处理
     
     - parameter button: 多选按钮
     */
    @objc fileprivate func didTappedSelectButton(_ btn: UIButton) {
        selectButton.isSelected = !selectButton.isSelected
        for model in addGoodArray! {
            model.selected = selectButton.isSelected
        }
        
        reCalculateCount()
        
        tableView.reloadData()
    }
}

// MARK:- ShoppingCartCellDelegate 代理方法

extension ShoppingCartViewController: ShoppingCartCellDelegate {
    /**
     当点击了cell中加、减按钮
     
     - parameter cell:       被点击的cell
     - parameter button:     被点击的按钮
     - parameter countLabel: 显示数量的label
     */
    func shoppingCartCell(_ cell: ShoppingCartCell, button: UIButton, countLabel: UILabel) {
        // 根据 cell 获取当前模型
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let model = addGoodArray![indexPath.row]
        
        if button.tag == 10 {
            if model.count < 1 {
                print("数量不能为0")
                return
            }
            
            model.count -= 1
            countLabel.text = "\(model.count)"
        } else {
            model.count += 1
            countLabel.text = "\(model.count)"
        }
        
        // 重新计算商品数量
        reCalculateCount()
    }
    /**
     重新计算总价
     */
    func reCalculateTotalPrice() {
        reCalculateCount()
    }
}
