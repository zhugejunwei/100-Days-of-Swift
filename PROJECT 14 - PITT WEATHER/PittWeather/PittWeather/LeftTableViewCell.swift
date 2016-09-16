//
//  LeftTableViewCell.swift
//  PittWeather
//
//  Created by 诸葛俊伟 on 9/2/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherBgView: UIView!
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = leftControllerAndRightControllerBGColor
        
        self.selectionStyle = .None
        
        // 设置圆角
        self.weatherBgView.layer.cornerRadius = 8.0
        self.weatherBgView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
