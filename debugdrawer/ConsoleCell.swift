//
//  ConsoleCell.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

let ConsoleCellIdentifier = "ConsoleCell"

class ConsoleCell: UITableViewCell {

    @IBOutlet weak var consoleView: UITextView!
    @IBOutlet weak var commandField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commandField.attributedPlaceholder = NSAttributedString(string:"Waiting for input...", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
