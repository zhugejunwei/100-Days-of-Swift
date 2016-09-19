//
//  TableViewCell.swift
//  PullToRefresh
//
//  Created by 诸葛俊伟 on 9/18/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell
{
    @IBOutlet weak var emojiLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
