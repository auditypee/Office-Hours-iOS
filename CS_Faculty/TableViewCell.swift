//
//  TableViewCell.swift
//  CS_Faculty
//
//  Created by Audi Bayron on 4/6/17.
//  Copyright © 2017 Audi Bayron. All rights reserved.
//
/*******************************************************************************************************
 * Cell - contains UI stuff to be changed based on code
 ******************************************************************************************************/

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellNameLbl: UILabel!
    
    @IBOutlet weak var cellAvailLbl: UILabel!

    @IBOutlet weak var cellClassTV: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
