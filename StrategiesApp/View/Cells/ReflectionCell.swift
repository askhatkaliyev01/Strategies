//
//  ReflectionCell.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class ReflectionCell: MGSwipeTableCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var deleteConst: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
    }
    @objc func showDeleteButton() {
        UIView.animate(withDuration: 0.3) {
            self.deleteConst.constant = 70.0
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @objc func hideDeleteButton() {
        UIView.animate(withDuration: 0.3) {
            self.deleteConst.constant = 16.0
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    @IBAction func deleteBtnTouched(_ sender: Any) {
        self.showSwipe(.rightToLeft, animated: true)
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
