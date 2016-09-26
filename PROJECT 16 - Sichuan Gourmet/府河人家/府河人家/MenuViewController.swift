//
//  MenuTableViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/21/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit
import SnapKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class MenuViewController: UIViewController
{
    // MARK: - Property
    
    // food array
    fileprivate var foodArray = [Array<Food>]() {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate let foodListCellIdentifier = "foodListCell"
    
    // food in shopping cart
    fileprivate var addFoodArray = [Food]()
    
    fileprivate var path: UIBezierPath?
    
    var layer: CALayer?
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         提醒：
         view 只会 load 一次，一般在这里在这里进行一些初始化的工作，我们一般不用 init 方法，因为此时 outlet 已经设置完毕了。我们一般也将 update UI 的工作放在这个方法里。但是 view 的 geometry 不在这里设置，因为还不知道使用的设备是什么。这里的 geometry 的意思是 view 的大小尺寸，横向还是纵向之类的。具体请见（http://www.jianshu.com/p/5e784091dae3）。
         */
        
        // 初始化一些假数据
        for i in 0..<5 {
            var dict = [String:Any]()
            dict["foodImgName"] = "goodicon_\(i)"
            dict["meatName"] = "超好吃的\(i + 1)号大肉"
            dict["soupName"] = "美滋滋的\(i + 1)号菜汤"
            dict["originPrice"] = "8"
            dict["vipPrice"] = "6.8"
            // 字典转模型并将模型添加到模型数组中
            foodArray.append([Food(dict: dict)])
        }
        
        prepareUI()
    }
    
    func getList(_ refreshControl: UIRefreshControl) {
        foodArray.removeAll()
        foodArray = [Array<Food>]()
        for i in 0..<9 {
            var dict = [String:Any]()
            dict["foodImgName"] = "goodicon_\(i)"
            dict["meatName"] = "超好吃的\(i + 1)号大肉"
            dict["soupName"] = "美滋滋的\(i + 1)号菜汤"
            dict["originPrice"] = "8"
            dict["vipPrice"] = "6.8"
            // 字典转模型并将模型添加到模型数组中
            foodArray.append([Food(dict: dict)])
        }
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /**
         提醒：
         这是 view 即将呈现出来之前的方法，一般把需要大量运算的程序放在这里（比如多线程的操作），view 的 geometry 也是在这里设置的，但是如果要做旋转之类的操作，其它地方会响应这些操作。具体请见（http://www.jianshu.com/p/5e784091dae3）。
         */
        
        layoutUI()
    }

    fileprivate func prepareUI() {
        navigationItem.title = "Special Lunch"
        
        // shopping cart button
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
        
        // count label
        navigationController?.navigationBar.addSubview(addCountLabel)
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.addSubview(tableView)
        
        // register cell
        tableView.register(MenuListCell.self, forCellReuseIdentifier: foodListCellIdentifier)
        
        // Pull to refresh
        tableView.refreshControl = self.refreshControl
        refreshControl.addTarget(self, action: #selector(MenuViewController.getList), for: .valueChanged)
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSForegroundColorAttributeName: UIColor.white]
        let dateString = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(dateString)", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
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
    
    // MARK: - lazy vars
    fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    fileprivate lazy var cartButton: UIButton = {
        let cartBtn = UIButton(type: .custom)
        cartBtn.setImage(UIImage(named:"button_cart"), for: .normal)
        cartBtn.addTarget(self, action: #selector(didTappedCartBtn), for: .touchUpInside)
        cartBtn.sizeToFit()
        return cartBtn
    }()
    
    fileprivate lazy var addCountLabel: UILabel = {
        let countlabel = UILabel()
        countlabel.backgroundColor = UIColor.white
        countlabel.textColor = UIColor.purple
        countlabel.font = UIFont.systemFont(ofSize: 11)
        countlabel.textAlignment = .center
        countlabel.text = "\(self.addFoodArray.count)"
        countlabel.layer.cornerRadius = 7.5
        countlabel.layer.masksToBounds = true
        countlabel.layer.borderWidth = 1.0
        countlabel.layer.borderColor = UIColor.red.cgColor
        countlabel.isHidden = true
        return countlabel
    }()
}

// MARK: - TableView Delegate and DataSource

extension MenuViewController {
    // click cart button, present modally
    @objc func didTappedCartBtn() {
        let shoppingCartVC = ShoppingCartViewController()
        shoppingCartVC.addFoodArray = addFoodArray
        present(UINavigationController(rootViewController: shoppingCartVC), animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodListCellIdentifier, for: indexPath) as! MenuListCell
        cell.selectionStyle = .none
        cell.food = foodArray[indexPath.section][indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        switch section {
        case 0: return "Monday"
        case 1: return "Tuesday"
        case 2: return "Wednesday"
        case 3: return "Thursday"
        case 4: return "Friday"
        default: return "Weekend"
        }
    }
}

// MARK: - MenuListCellDelegate

extension MenuViewController: MenuListCellDelegate
{
    /**
     代理回调方法，当点击了cell上的购买按钮后触发
     
     - parameter cell:     被点击的cell
     - parameter iconView: 被点击的cell上的图标对象
     */
    func menuListCell(_ cell: MenuListCell, foodImageView: UIImageView)
    {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // retrieve the current food model, add it to shopping cart model
        let model = foodArray[indexPath.section][indexPath.row]
        addFoodArray.append(model)
        
        // recalculate the frame of imageView, start animation
        var rect = tableView.rectForRow(at: indexPath)
        rect.origin.y -= tableView.contentOffset.y
        var headRect = foodImageView.frame
        headRect.origin.y = rect.origin.y + headRect.origin.y - 64
        startAnimation(headRect, foodImageView: foodImageView)
    }
}

// MARK: - Animation throwing foodImage to shopping cart

extension MenuViewController: CAAnimationDelegate
{
    // start animation
    fileprivate func startAnimation(_ rect: CGRect, foodImageView: UIImageView)
    {
        if layer == nil {
            layer = CALayer()
            layer?.contents = foodImageView.layer.contents
            layer?.contentsGravity = kCAGravityResizeAspectFill
            layer?.bounds = rect
            layer?.cornerRadius = layer!.bounds.height * 0.5
            layer?.masksToBounds = true
            layer?.position = CGPoint(x: foodImageView.center.x, y: rect.minY + 96)
            KeyWindow.layer.addSublayer(layer!)
            
            // animation path
            path = UIBezierPath()
            path!.move(to: layer!.position)
            path!.addQuadCurve(to: CGPoint(x:SCREEN_WIDTH - 25, y: 35), controlPoint: CGPoint(x: SCREEN_WIDTH * 0.5, y: rect.origin.y - 80))
        }
        groupAnimation()
    }
    
    // start group animation: throw, larger, smaller image
    fileprivate func groupAnimation()
    {
        tableView.isUserInteractionEnabled = false
        
        // move path
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path!.cgPath
        animation.rotationMode = kCAAnimationRotateAuto
        
        // larger image
        let bigAnimation = CABasicAnimation(keyPath: "transform.scale")
        bigAnimation.duration = 0.5
        bigAnimation.fromValue = 1
        bigAnimation.toValue = 2
        bigAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // smaller image
        let smallAnimation = CABasicAnimation(keyPath: "transform.scale")
        smallAnimation.beginTime = 0.5
        smallAnimation.duration = 1
        smallAnimation.fromValue = 2
        smallAnimation.toValue = 0.5
        smallAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation, bigAnimation, smallAnimation]
        groupAnimation.duration = 1.5
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self
        layer?.add(groupAnimation, forKey: "groupAnimation")
    }
    
    // end image animation, start other animations
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        if anim == layer?.animation(forKey: "groupAnimation")
        {
            // start user interaction
            tableView.isUserInteractionEnabled = true
            
            // hide layer
            layer?.removeAllAnimations()
            layer?.removeFromSuperlayer()
            layer = nil
            
            // if user buy any food, show the count label
            if self.addFoodArray.count > 0 {
                addCountLabel.isHidden = false
            }
            
            // show the count label
            let goodCountAnimation = CATransition()
            goodCountAnimation.duration = 0.25
            addCountLabel.text = "\(self.addFoodArray.count)"
            addCountLabel.layer.add(goodCountAnimation, forKey: nil)
            
            // shopping cart shaking
            let cartAnimation = CABasicAnimation(keyPath: "transform.translation.y")
            cartAnimation.duration = 0.25
            cartAnimation.fromValue = -5
            cartAnimation.toValue = 5
            cartAnimation.autoreverses = true
            cartButton.layer.add(cartAnimation, forKey: nil)
        }
    }
}
