//
//  ResultsTableViewCell.swift
//  localSearch
//
//  Created by Nicolas Roldos on 4/8/15.
//  Copyright (c) 2015 Nicolas Roldos. All rights reserved.
//

import UIKit





class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: true)
        // Configure the view for the selected state
    }

}

