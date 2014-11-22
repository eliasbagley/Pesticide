//
//  PesticideCell.swift
//  debugdrawer
//
//  Created by Daniel Gubler on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

class PesticideCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setName (name: String){
        self.nameLabel.text = name
    }

}
