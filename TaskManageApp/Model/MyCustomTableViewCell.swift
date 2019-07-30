//
//  MyCustomTableViewCell.swift
//  TaskManageApp
//
//  Created by 堀内　竣平 on 2019/05/06.
//  Copyright © 2019 堀内　竣平. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priorityLabel: UILabel!
    @IBOutlet var dueLabel: UILabel!
    @IBOutlet var descText: UITextView!
    @IBOutlet var genreText: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cod
        descText.textAlignment = NSTextAlignment.left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
