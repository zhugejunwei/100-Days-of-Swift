//
//  ViewController.swift
//  PickerViewDemo
//
//  Created by 诸葛俊伟 on 9/12/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//


/*
 
 About delegate and dataSource
 
You need to implement all the required methods of UIPickerViewDataSource and UIPickerViewDelegate, if you want to conform to these protocols.
 
 if you don't implement all the required methods declared by a protocol you are going to get a compile time error instead of a run time exception.
*/

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var startBtn: UIButton!
    
    var loseImage: UIImage?
    var winImage: UIImage?
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loseImage = UIImage(named: "lose")
        winImage = UIImage(named: "win")
        
        let img1 = UIImage(named: "img1")!
        let img2 = UIImage(named: "img2")!
        let img3 = UIImage(named: "img3")!
        let img4 = UIImage(named: "img4")!
        let img5 = UIImage(named: "img5")!
        let img6 = UIImage(named: "img6")!
        let img7 = UIImage(named: "img7")!
        let img8 = UIImage(named: "img8")!
        let img9 = UIImage(named: "img9")!
        let img10 = UIImage(named: "img10")!
        
        images = [img1, img2, img3, img4, img5, img6, img7, img8, img9, img10]
            
        // delegate and datasource
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    let kImageTag = 1
    
    // UIPickerViewDelegate 中定义的方法，该方法返回的UIView将作为
    // UIPickerView 中指定列和列表项的UI控件
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var view = view
        // 如果可重用的view的tag不等于kImageTag，表明该view已经不存在，需要重新创建
        if view?.tag == nil || view?.tag != kImageTag {
            
            view = UIImageView(image: images[row])
            view?.tag = kImageTag
            view?.userInteractionEnabled = false
        }
        return view!
    }
    
    // UIPickerViewDelegate中定义的方法，该方法的返回值决定列表项的高度
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    // UIPickerViewDelegate中定义的方法，该方法的返回值决定列表项的宽度
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
    
    @IBAction func click(sender: UIButton) {
        self.startBtn.enabled = false
        self.img.image = nil // 清空界面上image控件中的图片
        // 定义一个NSMutableDictionary来记录每个随机数的出现次数
        var result = [Int: Int]()
        
        // 背景音乐
        SystemSoundID.playFileNamed("play")
        
        for i in 0..<5 {
            // 生成 0～images.count 之间的随机数
            var selectedValue = Int(arc4random_uniform(UInt32(images.count)))
            
            // 下面这是错的。。。。暂时琢磨不出来怎么做动画。。。
            func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { ////////
                var row = row
                row = selectedValue
                var component = component
                component = i
            }
            
            // 在 result 中为该随机数记录次数
            if (result[selectedValue] != nil) {
                let newCount = result[selectedValue]
                result[selectedValue] = newCount! + 1
            } else {
                result[selectedValue] = 1
            }
            
            // 随机数的最大出现次数 
            var maxOccur = 1
            for n in result.keys {
                // 只要任何随机数的出现次数大于 maxOccur
                if result[n] > maxOccur {
                    maxOccur = result[n]!
                }
            }
            
            if maxOccur >= 2 {
                // 如果赢了，延迟 0.5 秒执行 showWin() 方法
                delay(0.5, closure: {
                    self.showWin()
                })
            } else {
                // 如果输了，延迟 0.5 秒执行 showLose() 方法
                delay(0.5, closure: {
                    self.showLose()
                })
            }

        }
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func showWin() {
        SystemSoundID.playFileNamed("win")
        self.img.image = winImage
        self.startBtn.enabled = true
    }
    
    func showLose() {
        self.img.image = loseImage
        self.startBtn.enabled = true
    }
    
    
    
    
    
/*
    // in Swift 3
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
 */
    
    
    /*
     // Demo_1
     
     // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cam = component == 0 ? campus : address // 第一列为学校，第二列为具体地址
        let add = component == 0 ? "campus" : "address"
        let alert = UIAlertController(title: "Your Address is", message: "Your \(add) is \(cam[row])", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            switch action.style {
            case .Default:
                print("default")
            case .Cancel:
                print("cancel")
            case .Destructive:
                print("destructive")
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
 */
    
    /*
    // Demo_2
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedCamp = campus[row]
            // 根据选中的校园加载第二个列表
            self.pickerView.reloadComponent(1)
        } else {
            let camp = component == 0 ? campus : address[selectedCamp]!
            let tip = component == 0 ? "campus" : "address"
            // 使用一个UIAlertView来显示用户选中的列表项
            let alert = UIAlertController(title: "Your address is", message: "Your \(tip) is \(camp[row])", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    // 设置各列的宽度
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 100
        } else {
            return 250
        }
    }
    */
    
}

extension SystemSoundID {
    static func playFileNamed(fileName: String, withExtenstion fileExtension: String? = "wav") {
        var sound: SystemSoundID = 0
        if let soundURL = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileExtension) {
            AudioServicesCreateSystemSoundID(soundURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}
