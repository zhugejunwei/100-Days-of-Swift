//
//  Food.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/22/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class Food: NSObject
{
    var alreadyInShoppingCart: Bool = false
    
    var meatName: String?
    
    var soupName: String?
    
    // food image name
    var foodImgName: String?
    
    // the amount of food users bought, default is 1
    var count: Int = 1
    
    // if people use vip card, the price will be lower
    var vipPrice: String?
    
    // original price of food
    var originPrice: String?
    
    var selected: Bool = true
    
    init(dict: [String:Any]) {
        super.init()
        
        // kvo
        setValuesForKeys(dict)
    }
    
    // 防止对象属性在kvc的dict的key不匹配而崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
