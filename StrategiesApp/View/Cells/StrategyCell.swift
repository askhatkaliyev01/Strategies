//
//  StrategyCell.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 25.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit

class StrategyCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var tickImgV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
