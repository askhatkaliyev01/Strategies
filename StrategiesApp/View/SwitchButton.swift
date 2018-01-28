//
//  SwitchButton.swift
//  UniversitiesOfTheSpiritApp
//
//  Created by Yerassyl Yerlanov on 13.10.17.
//  Copyright © 2017 Kumara Creations. All rights reserved.
//

import UIKit

class SwitchButton: UIButton {
    
    var isOn: Bool!
    var isSong: Bool!
    var imgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
        setOn()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgV.frame = CGRect(x:0.0, y:0.0, width:self.frame.size.width, height:self.frame.size.height)
    }
    
    
    func setOn() {
        isOn = true
        if isSong {
            imgV.image = UIImage(named:"Song Selection Switch On")
        }
        else {
            imgV.image = UIImage(named:"Switch on Thin")
        }
    }
    func setOff() {
        isOn = false
        if isSong {
            imgV.image = UIImage(named:"Song Selection Switch Off")
        }
        else {
            imgV.image = UIImage(named:"Switch off Thin")
        }
    }
    
    func initialize() {
        self.setTitle("", for: .normal)
        imgV = UIImageView()
        self.addSubview(imgV)
        isSong = false
        //        self.addTarget(self, action: #selector(switchTouched), for: .touchUpInside)
    }
}
