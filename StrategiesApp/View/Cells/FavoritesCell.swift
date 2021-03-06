//
//  FavoritesCell.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class FavoritesCell: MGSwipeTableCell {

    @IBOutlet weak var imgV: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteConst: NSLayoutConstraint!
    
    @IBOutlet weak var infoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.imgV.backgroundColor = Helper.rgba(red: 66, green: 29, blue: 29, alpha: 1)
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
            self.deleteConst.constant = 8.0
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
    
    func initWithFav(fav:NSDictionary) {
        let number = String(format: "%02d",  Int("\(fav["number"]!)")!)

        titleLbl.text = "\(number). \(fav["title"]! as! String)"
        infoLbl.text = fav["body"]! as! String
        if fav["type"] as! String == "light" {
            imgV.image = UIImage(named:"Dark_\(number)_Favorite")
        }
        else {
            imgV.image = UIImage(named:"Light_\(number)_Favorite")
        }
    }

}
