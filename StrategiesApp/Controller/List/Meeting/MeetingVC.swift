//
//  MeetingVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 24.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class MeetingVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var firstBlock: UILabel!
    @IBOutlet weak var secondBlock: UILabel!
    @IBOutlet weak var thirdBlock: UILabel!
    var titleText:String?
    var mainDB = MainDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLbl.text = titleText!
        mainDB.setTitleStyle(lbl: titleLbl)
        
        firstBlock.text = mainDB.translateString(str: "MTC - first block text")
        secondBlock.text = mainDB.translateString(str: "MTC - second block text")
        thirdBlock.text = mainDB.translateString(str: "MTC - third block text")
        
        mainDB.setTextStyle(lbl: firstBlock)
        mainDB.setTextStyle(lbl: secondBlock)
        mainDB.setTextStyle(lbl: thirdBlock)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
}
