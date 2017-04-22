//
//  TableViewCell.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellNameLbl: UILabel!
    
    @IBOutlet weak var cellAvailLbl: UILabel!
    
    @IBOutlet weak var cellOfficLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
