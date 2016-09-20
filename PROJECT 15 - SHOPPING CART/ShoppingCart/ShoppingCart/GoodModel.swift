//
//  GoodModel.swift
//  ShoppingCart
//
//  Created by 诸葛俊伟 on 9/19/16.
//  Copyright © 2016 ShoppingCart. All rights reserved.
//

import UIKit

class GoodModel: NSObject
{
    var alreadyInShoppingCart: Bool = false
    
    // 商品图片名称
    var iconName: String?
    
    // Good's title
    var title: String?
    
    // Description
    var desc: String?
    
    // 购买的商品数量，默认为 0
    var count: Int = 1
    
    var newPrice: String?
    
    var oldPrice: String?
    
    var selected: Bool = true
    
    init(dict: [String:AnyObject]) {
        super.init()
        
        // 使用 kvo 为当前对象属性设置值
        setValuesForKeys(dict)
    }
    
    // 防止对象属性在kvc的dict的key不匹配而崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
