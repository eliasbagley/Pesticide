//
//  CommandCell.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

let CommandCellIdentifier = "CommandCell"

class CommandCell: UITableViewCell {

    @IBOutlet weak var commandField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commandField.attributedPlaceholder = NSAttributedString(string:"Waiting for input...", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
