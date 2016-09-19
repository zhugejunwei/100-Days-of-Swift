//
//  MealTableViewController.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/6/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var meals = [[Meal]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleMeals()
    }
    
    fileprivate func loadSampleMeals() {
        let mealImage1 = UIImage(named: "meal1")
        let meal1 = Meal(mealImage: mealImage1, cnName: "笋尖肉丝+糖醋白菜+番茄蛋汤", enName: "shredded pork w. bamboo shot +sweet & sour napa + tomato egg soup")
        
        let mealImage2 = UIImage(named: "meal2")
        let meal2 = Meal(mealImage: mealImage2, cnName: "豆花鱼片+干煸芥蓝+大骨汤", enName: "shredded pork w. bamboo shot +sweet & sour napa + tomato egg soup")

        let mealImage3 = UIImage(named: "meal3")
        let meal3 = Meal(mealImage: mealImage3, cnName: "麻辣香锅排骨+时令蔬菜+酸辣汤", enName: "shredded pork w. bamboo shot +sweet & sour napa + tomato egg soup")

        let mealImage4 = UIImage(named: "meal4")
        let meal4 = Meal(mealImage: mealImage4, cnName: "盐煎肉炒包菜+卤蛋+上海苗+紫菜蛋花汤", enName: "shredded pork w. bamboo shot +sweet & sour napa + tomato egg soup")

        let mealImage5 = UIImage(named: "meal5")
        let meal5 = Meal(mealImage: mealImage5, cnName: "鱼香肉丝+清炒豆芽+酸菜鱼片汤", enName: "shredded pork w. bamboo shot +sweet & sour napa + tomato egg soup")
        meals.append([meal1])
        meals.append([meal2])
        meals.append([meal3])
        meals.append([meal4])
        meals.append([meal5])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        cell.cnNameLabel.text = meal.cnName
        cell.enNameLabel.text = meal.enName
        cell.imageLabel.image = meal.mealImage
        cell.imageLabel.layer.cornerRadius = 10.0
        cell.imageLabel.clipsToBounds = true
        cell.imageLabel.layer.borderWidth = 1.0
        cell.imageLabel.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "周一"
        case 1: return "周二"
        case 2: return "周三"
        case 3: return "周四"
        case 4: return "周五"
        default: return "周末"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
