//
//  Tool.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/6/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class Tool {
    class func getCurDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(date)
    }
}
