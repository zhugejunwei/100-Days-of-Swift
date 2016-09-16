//
//  WorkoutTableViewCell.swift
//  8 Minute Workout
//
//  Created by 诸葛俊伟 on 9/14/16.
//  Copyright © 2016 University of Pittsburgh. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell
{
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var textCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
