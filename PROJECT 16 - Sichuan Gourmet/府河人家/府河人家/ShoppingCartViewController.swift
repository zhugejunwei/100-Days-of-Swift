//
//  ShoppingCartViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/23/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

class ShoppingCartViewController: UIViewController, UIGestureRecognizerDelegate
{
    // MARK: - Property
    
    var addFoodArray: [Food]?
    
    // total price
    var price: Float = 0.0
    
    fileprivate var shoppingCartCellIdentifier = "shoppingCarCell"
    
    // MARK: - Lifecycle
    
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
        navigationItem.title = "Shopping Cart"
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(ShoppingCartViewController.didTappedBackButton))
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = UIColor.white
        tableView.rowHeight = 80
        tableView.register(ShoppingCartCell.self, forCellReuseIdentifier: shoppingCartCellIdentifier)
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
    
    // MARK: - lazy vars
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate lazy var bottomView: UIView = {
       let botView = UIView()
        botView.backgroundColor = UIColor.white
        return botView
    }()
    
    fileprivate lazy var selectButton: UIButton = {
        let select = UIButton(type: .custom)
        select.setImage(UIImage(named: "check_n"), for: UIControlState())
        select.setImage(UIImage(named: "check_y"), for: UIControlState())
        select.setTitle("All\\None", for: UIControlState())
        select.setTitleColor(UIColor.gray, for: UIControlState())
        select.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        select.addTarget(self, action: #selector(ShoppingCartViewController.didTappedSelectButton), for: .touchUpInside)
        select.isSelected = true
        select.sizeToFit()
        return select
    }()
    
    fileprivate lazy var totalPriceLabel: UILabel = {
        let price = UILabel()
        let attributeText = NSMutableAttributedString(string: "Subtotal: \(self.price)")
        attributeText.setAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSMakeRange(5, attributeText.length - 5))
        price.attributedText = attributeText
        price.sizeToFit()
        return price
    }()
    
    fileprivate lazy var buyButton: UIButton = {
        let buy = UIButton(type: .custom)
        buy.setTitle("Pay", for: UIControlState())
        buy.setBackgroundImage(UIImage(named: "button_cart_add"), for: UIControlState())
        buy.layer.cornerRadius = 15
        buy.layer.masksToBounds = true
        return buy
    }()
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addFoodArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCartCellIdentifier, for: indexPath) as! ShoppingCartCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.food = addFoodArray?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reCalculateCount()
    }
}

extension ShoppingCartViewController
{
    @objc fileprivate func didTappedBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func reCalculateCount()
    {
        for model in addFoodArray! {
            if model.selected == true {
                price += Float(model.count) * (model.vipPrice! as NSString).floatValue
            }
        }
        // assign price
        let attributeText = NSMutableAttributedString(string: "Subtotal: \(self.price)")
        attributeText.setAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSMakeRange(5, attributeText.length - 5))
        totalPriceLabel.attributedText = attributeText
        price = 0
        tableView.reloadData()
    }
    
    // selectAll button
    @objc fileprivate func didTappedSelectButton(_ btn: UIButton) {
        selectButton.isSelected = !selectButton.isSelected
        for model in addFoodArray! {
            model.selected = selectButton.isSelected
        }
        reCalculateCount()
        
        tableView.reloadData()
    }
}

extension ShoppingCartViewController: ShoppingCartCellDelegate
{
    /**
     当点击了cell中加、减按钮
     
     - parameter cell:       被点击的cell
     - parameter button:     被点击的按钮
     - parameter countLabel: 显示数量的label
     */
    
    func shoppingCartCell(_ cell: ShoppingCartCell, button: UIButton, countLabel: UILabel) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let model = addFoodArray![indexPath.row]
        if button.tag == 10 {
            if model.count < 1 {
                print("Amount number cannot be negative!")
                return
            }
            model.count -= 1
            countLabel.text = "\(model.count)"
        } else {
            model.count += 1
            countLabel.text = "\(model.count)"
        }
        reCalculateCount()
    }
    
    func reCalculateTotalPrice() {
        reCalculateCount()
    }
}



