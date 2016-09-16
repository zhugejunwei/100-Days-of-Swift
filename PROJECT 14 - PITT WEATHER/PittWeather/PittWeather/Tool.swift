//
//  Tool.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/4/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class Tool {
    class func returnDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "us")
        dateFormatter.dateFormat = "MM.dd"
        return dateFormatter.stringFromDate(date)
    }
    
    class func returnWeekDay(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "us")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
    }
    
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func returnWeatherBGColor(weatherType:String)->UIColor {
        let weatherTypePath = NSBundle.mainBundle().pathForResource("weatherBG", ofType: "plist")
        if weatherTypePath != nil {
            let json = NSDictionary(contentsOfFile: weatherTypePath!)
            
            for element in (json?.allKeys)! {
                if element as! String == weatherType || weatherType.hasPrefix(element as! String) {
                    let key = element as! String
                    let value = json![key] as! String
                    return Tool.colorWithHexString(value)
                }
            }
        }
        
        return UIColor.grayColor()
        
    }
    
}