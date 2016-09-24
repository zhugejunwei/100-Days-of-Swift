//
//  GoodListViewController.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/19/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
//

import UIKit
import SnapKit

// Screen Size
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class GoodListViewController: UIViewController
{
    // MARK: - Property
    
    // 商品模型数组初始化
    fileprivate var goodArray = [Array<GoodModel>]()
    
    // 商品列表cell的重用标识符
    fileprivate let goodListCellIdentifier = "goodListCell"
    
    // 已经添加进购物车的商品模型数组，初始化
    fileprivate var addGoodArray = [GoodModel]()
    
    fileprivate var path: UIBezierPath?
    
    var layer: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         提醒：
         view 只会 load 一次，一般在这里在这里进行一些初始化的工作，我们一般不用 init 方法，因为此时 outlet 已经设置完毕了。我们一般也将 update UI 的工作放在这个方法里。但是 view 的 geometry 不在这里设置，因为还不知道使用的设备是什么。这里的 geometry 的意思是 view 的大小尺寸，横向还是纵向之类的。具体请见（http://www.jianshu.com/p/5e784091dae3）。
         */
        // 初始化一些假数据
        for i in 0..<5 {
            var dict = [String:Any]()
            dict["iconName"] = "goodicon_\(i)"
            dict["title"] = "\(i + 1)号套餐"
            dict["desc"] = "这是第\(i + 1)号套餐"
            dict["oldPrice"] = "2\(i)"
            dict["newPrice"] = "1\(i)"
            // 字典转模型并将模型添加到模型数组中
            goodArray.append([GoodModel(dict: dict)])
        }
        
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /**
         提醒：
         这是 view 即将呈现出来之前的方法，一般把需要大量运算的程序放在这里（比如多线程的操作），view 的 geometry 也是在这里设置的，但是如果要做旋转之类的操作，其它地方会响应这些操作。具体请见（http://www.jianshu.com/p/5e784091dae3）。
         */
        
        layoutUI()
    }
    
    // 创建并添加子控件
    fileprivate func prepareUI() {
        navigationItem.title = "特别午餐"
        
        // shopping cart button
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        
        // count label
        navigationController?.navigationBar.addSubview(addCountLabel)
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        // add table view
        view.addSubview(tableView)
        
        // register cell
        tableView.register(GoodListCell.self, forCellReuseIdentifier: goodListCellIdentifier)
    }
    
    fileprivate func layoutUI() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        
        addCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.top.equalTo(10.5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
    }
    
    // MARK: - 懒加载
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var cartButton: UIButton = {
        let cartButton = UIButton(type: .custom)
        cartButton.setImage(UIImage(named: "button_cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(didTappedCartButton), for: .touchUpInside)
        cartButton.sizeToFit()
        return cartButton
    }()
    
    lazy var addCountLabel: UILabel = {
        let addCountLabel = UILabel()
        addCountLabel.backgroundColor = UIColor.white
        addCountLabel.textColor = UIColor.purple
        addCountLabel.font = UIFont.boldSystemFont(ofSize: 11)
        addCountLabel.textAlignment = .center
        addCountLabel.text = "\(self.addGoodArray.count)"
        addCountLabel.layer.cornerRadius = 7.5
        addCountLabel.layer.masksToBounds = true
        addCountLabel.layer.borderWidth = 1.0
        addCountLabel.layer.borderColor = UIColor.red.cgColor
        addCountLabel.isHidden = true
        return addCountLabel
    }()
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension GoodListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "周一"
        case 1: return "周二"
        case 2: return "周三"
        case 3: return "周四"
        case 4: return "周五"
        default: return "周末"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return goodArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // 从缓存池创建cell，如果没有从缓存池创建成功就根据注册的cell重用标识符创建一个新的cell
        let cell = tableView.dequeueReusableCell(withIdentifier: goodListCellIdentifier, for: indexPath) as! GoodListCell
        
        // 取消选中效果
        cell.selectionStyle = .none
        
        // 为cell传递数据
        cell.goodModel = goodArray[indexPath.section][indexPath.row]
        
        // 指定代理
        cell.delegate = self
        
        return cell
    }
}

// MARK: - view 上的事件处理

extension GoodListViewController
{
    /**
     当点击了购物车触发，modal到购物车控制器
     
     - parameter button: 购物车按钮
     */
    @objc fileprivate func didTappedCartButton(_ btn: UIButton) {
        let shoppingCarVC = ShoppingCartViewController()
        shoppingCarVC.addGoodArray = addGoodArray
        present(UINavigationController(rootViewController: shoppingCarVC), animated: true, completion: nil)
    }
}

// MARK: - GoodListCellDelegate 代理方法

extension GoodListViewController: GoodListCellDelegate
{
    /**
     代理回调方法，当点击了cell上的购买按钮后触发
     
     - parameter cell:     被点击的cell
     - parameter iconView: 被点击的cell上的图标对象
     */
    func goodListCell(_ cell: GoodListCell, iconView: UIImageView)
    {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // 获取当前模型，添加到购物车模型数组
        let model = goodArray[indexPath.section][indexPath.row]
        addGoodArray.append(model)
        
        // 重新计算iconView的frame，并开启动画
        var rect = tableView.rectForRow(at: indexPath)
        rect.origin.y -= tableView.contentOffset.y
        var headRect = iconView.frame
        headRect.origin.y = rect.origin.y + headRect.origin.y - 64
        startAnimation(headRect, iconView: iconView)
    }
}

// MARK: - 将图片抛入购物车的动画效果

extension GoodListViewController: CAAnimationDelegate
{
    /**
     开始动画
     - parameter rect:     商品图标对象的frame
     - parameter iconView: 商品图标对象
     */
    fileprivate func startAnimation(_ rect: CGRect, iconView: UIImageView)
    {
        if layer == nil {
            layer = CALayer()
            layer?.contents = iconView.layer.contents
            layer?.contentsGravity = kCAGravityResizeAspectFill
            layer?.bounds = rect
            layer?.cornerRadius = layer!.bounds.height * 0.5
            layer?.masksToBounds = true
            layer?.position = CGPoint(x: iconView.center.x, y: rect.minY + 96)
            UIApplication.shared.keyWindow?.layer.addSublayer(layer!)
            // 动画路径
            path = UIBezierPath()
            path!.move(to: layer!.position)
            path!.addQuadCurve(to: CGPoint(x: SCREEN_WIDTH - 25, y: 35), controlPoint: CGPoint(x:SCREEN_WIDTH * 0.5, y: rect.origin.y - 80))
        }
        // 组动画
        groupAnimation()
    }
    
    /**
     组动画，帧动画抛入购物车，并放大、缩小图层增加点动效。
     */
    fileprivate func groupAnimation()
    {
        // 开始动画禁用tableview交互
        tableView.isUserInteractionEnabled = false
        
        // 帧动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path!.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        
        // 放大动画
        let bigAnimation = CABasicAnimation(keyPath: "transform.scale")
        bigAnimation.duration = 0.5
        bigAnimation.fromValue = 1
        bigAnimation.toValue = 2
        bigAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // 缩小动画
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1.5
        smallAnimation.fromValue = 2
        smallAnimation.toValue = 0.5
        smallAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // 组动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, bigAnimation, smallAnimation]
        groupAnimation.duration = 2
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        layer?.add(groupAnimation, forKey: "groupAnimation")
    }
    
    /**
     动画结束后做一些操作
     */
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // 如果动画是我们的组动画，才开始一些操作
        if anim == layer?.animation(forKey: "groupAnimation") {
            // 开启交互
            tableView.isUserInteractionEnabled = true
            
            // 隐藏图层
            layer?.removeAllAnimations()
            layer?.removeFromSuperlayer()
            layer = nil
            
            // 如果商品数大于0，显示购物车里的商品数量
            if self.addGoodArray.count > 0 {
                addCountLabel.isHidden = false
            }
            
            // 商品数量渐出
            let goodCountAnimation = CATransition()
            goodCountAnimation.duration = 0.25
            addCountLabel.text = "\(self.addGoodArray.count)"
            addCountLabel.layer.add(goodCountAnimation, forKey: nil)
            
            // 购物车抖动
            let cartAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            cartAnimation.duration = 0.25
            cartAnimation.fromValue = -5
            cartAnimation.toValue = 5
            cartAnimation.autoreverses = true
            cartButton.layer.add(cartAnimation, forKey: nil)
        }
    }
}
