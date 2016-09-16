//
//  MainViewController.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/2/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//
/*
 华氏 <-> 摄氏
 F = 9/5 C + 32
 C = 5/9 (F -32)
 */

// api key: 1ce1096ef49c65d1
// http://api.wunderground.com/api/1ce1096ef49c65d1/conditions/q/PA/\(cityName).json

import UIKit

class MainViewController: UIViewController, NSXMLParserDelegate {

    var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Tool.colorWithHexString("ff6666")
        
        self.layoutNavigationBar(Tool.returnDate(NSDate()), weekDay: Tool.returnWeekDay(NSDate()), cityName: "Pittsburgh")
        
        self.request("Pittsburgh")
    }
    
    func layoutNavigationBar(date: String, weekDay: String, cityName: String) {
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let categoryBarItem = UIBarButtonItem(image: UIImage(named: "category_hover"), style: .Plain, target: self, action: #selector(MainViewController.chooseDateAction(_:)))
        categoryBarItem.imageInsets = UIEdgeInsetsMake(4, 0, 0, 0)
        let dateBarItem = UIBarButtonItem(title: date + "/" + weekDay, style: .Plain, target: self, action: #selector(MainViewController.chooseDateAction(_:)))
        
        self.navigationItem.leftBarButtonItems = [categoryBarItem, dateBarItem]
        
        let shareBarItem = UIBarButtonItem(image: UIImage(named: "share_small_hover"), style: .Plain, target: self, action: #selector(MainViewController.shareAction(_:)))
        let cityBarItem = UIBarButtonItem(title: cityName, style: .Plain, target: nil, action: nil)
        cityBarItem.enabled = false
        let settingBarItem = UIBarButtonItem(image: UIImage(named: "settings_hover"), style: .Plain, target: self, action: #selector(MainViewController.settingAction(_:)))
        
        self.navigationItem.rightBarButtonItems = [settingBarItem, cityBarItem, shareBarItem]
    }
    
    func chooseDateAction(sender: UIBarButtonItem) {
        
    }
    
    func shareAction(sender: UIBarButtonItem) {
        
    }
    
    func settingAction(sender: UIBarButtonItem) {
        
    }
    
    
    func request(cityName: String) {
        // 如何从服务器端请求数据
        // xml, json 解析
        let session = NSURLSession.sharedSession()
        
        // 向服务器提交数据
        //        session.dataTaskWithRequest(<#T##request: NSURLRequest##NSURLRequest#>, completionHandler: <#T##(NSData?, NSURLResponse?, NSError?) -> Void#>)
        
//        let cityName = "Pittsburgh"
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather/?q=\(cityName),%20US&units=imperial&appid=33ecc797b8d0f0faed21c3a0bf961d8d&mode=json".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        //        let urlString = "http://api.openweathermap.org/data/2.5/weather/?q=\(cityName),%20US&units=imperial&appid=33ecc797b8d0f0faed21c3a0bf961d8d&mode=xml".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let url = NSURL(string: urlString!)
        // 向服务器请求数据
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            // data 请求回来的数据
            // response 里面包含 数据长度 服务器信息
            // error nil 表示请求成功
            if error == nil {
                // json 解析
                let weatherInfo = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let array1 = weatherInfo!["weather"] as! NSArray
                let dic = array1[0] as! NSDictionary
                let dic2 = weatherInfo!["main"] as! NSDictionary
                let weather = dic["main"] as! String
                let tempMax = dic2["temp_max"] as! NSNumber as NSInteger
                let tempMin = dic2["temp_min"] as! NSNumber as NSInteger
                let res = [weather, tempMax, tempMin] as NSArray
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.backgroundColor = Tool.returnWeatherBGColor(weather)
                    NSNotificationCenter.defaultCenter().postNotificationName(LeftControllerTypeChangedNotification, object: nil, userInfo: ["data":res])
                })
                
                //                // xml 解析
                //                let xmlParser = NSXMLParser(data: data!)
                //                xmlParser.delegate = self
                //                // 开始解析
                //                xmlParser.parse()
            }
        }
        // 开始请求
        task.resume()
    }
    
//    // xml, 开始解析，拿到节点信息
//    var currentNodeName: String!
//    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
//        currentNodeName = elementName
//    }
//    // xml, 解析完成，拿到节点中的值
//    func parser(parser: NSXMLParser, foundCharacters string: String) {
//        // string 表示节点中的值
//        let newStr = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        if newStr != "" {
//            print("\(currentNodeName)---->\(newStr)")
//        }
//    }
}
