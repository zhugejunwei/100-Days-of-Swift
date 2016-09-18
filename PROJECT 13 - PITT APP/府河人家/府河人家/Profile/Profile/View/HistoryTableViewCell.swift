//
//  HistoryTableViewCell.swift
//  府河人家
//
//  Created by 诸葛俊伟 on 9/10/16.
//  Copyright © 2016 Sichuan Gourmet. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
