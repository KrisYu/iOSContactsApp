//
//  PersonTableViewCell.swift
//  Address
//
//  Created by 雪 禹 on 3/17/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
