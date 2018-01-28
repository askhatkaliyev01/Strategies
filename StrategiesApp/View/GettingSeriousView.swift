//
//  GettingSeriousView.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 26.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit

@objc protocol GettingSeriousViewDelegate {
    func nextTouched(with:Int)
}

class GettingSeriousView: UIView {

    @IBOutlet weak var gettingLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var dontShowLbl: UILabel!
    @IBOutlet weak var dontShowBtn: UIButton!
    
    var mainDB = MainDB()
    
    weak var delegate: GettingSeriousViewDelegate?

    
    class func instanceFromNib() -> GettingSeriousView {
        let gV:GettingSeriousView = UINib(nibName: "GettingSeriousView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! GettingSeriousView
        gV.frame = CGRect(x:0,y:84,width:Helper.scn_width,height:Helper.scn_height-84)

        return gV
    }
    
    func firstInit() {
        self.backgroundColor = .clear
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1).cgColor
        
        dontShowBtn.layer.cornerRadius = 3
        dontShowBtn.layer.borderWidth = 1
        dontShowBtn.layer.borderColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1).cgColor
        dontShowBtn.tag = 0
        
        self.initText()
    }
    func initText() {
        gettingLbl.text = mainDB.translateString(str: "Getting Serious")
        textView.text = mainDB.translateString(str: "Getting Serious Text")
        dontShowLbl.text = mainDB.translateString(str: "Don't show again")
        
        mainDB.setTitleStyle(lbl: gettingLbl)
        mainDB.setTextStyle(lbl: textView)
        mainDB.setTextStyle(lbl: dontShowLbl)
    }
    
    @IBAction func dontShowBtnTouched(_ sender: Any) {
        if dontShowBtn.tag == 0 {
            dontShowBtn.tag = 1
            dontShowBtn.backgroundColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1)
            mainDB.setDontShowAgain(isShow: true)
        }
        else {
            dontShowBtn.tag = 0
            dontShowBtn.backgroundColor = .clear
            mainDB.setDontShowAgain(isShow: false)
        }
    }
    @IBAction func nextBtnTouched(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }) { (completed) in
            if self.delegate != nil {
                self.delegate!.nextTouched(with: self.dontShowBtn.tag)
            }
            self.removeFromSuperview()
        }
    }
}