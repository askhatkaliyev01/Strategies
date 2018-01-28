//
//  ListCell.swift
//  StrategiesApp
//
//  Created by Ahaha on 24.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var titleTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initWithTitle(title:String) {
        titleTextLbl.text = title
    }
    
}
