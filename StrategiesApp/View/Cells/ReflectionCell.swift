//
//  ReflectionCell.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 25.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class ReflectionCell: MGSwipeTableCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initReflection(ref:NSDictionary){
        let strategy = ref["strategy"] as! NSDictionary
        titleLbl.text = strategy["title"] as? String
//        inMyLifeTextLbl.text = ref["in_my_life"] as? String
        infoLbl.text = ref["in_my_life"] as? String
    }

}
