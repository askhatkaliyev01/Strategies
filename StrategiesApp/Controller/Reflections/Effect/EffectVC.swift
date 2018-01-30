//
//  EffectVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

@objc protocol EffectDelegate {
    func effectAdded(effect:String)
}

class EffectVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var digitsHolderView: UIView!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    weak var delegate: EffectDelegate?

    var buttons:NSMutableArray! = NSMutableArray()
    var selectedDigit:Int = 0
    var reflection:NSMutableDictionary! = nil
    var mainDB = MainDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initText()
        addDigits()
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1).cgColor
        nextBtn.isHidden = true
    }
    func initText() {
        nextBtn.setTitle(mainDB.translateString(str: "Next"), for: .normal)
        titleLbl.text = mainDB.translateString(str: "Reflections")
        infoLbl.text = mainDB.translateString(str: "How effectively this strategy of darkness works on me on a scale of 0-10:")
        noteLbl.text = mainDB.translateString(str: "Note: 0 being never works at all, 10 being works every time.")
        
        mainDB.setTitleStyle(lbl: titleLbl)
        mainDB.setTitleStyle(lbl: infoLbl)
        mainDB.setTextStyle(lbl: noteLbl)
    }
    func addDigits() {
        
        for i in 1 ... 10 {
            let btn = UIButton()
            btn.frame = CGRect(x:Double(i-1)*30.0,y:0.0,width:30.0,height:30.0)
            digitsHolderView.addSubview(btn)
            btn.setImage(UIImage(named:"free_\(i)"), for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)
            buttons.add(btn)
        }
    }
    @objc func buttonTouched(button:UIButton) {
        for i in 0 ... 9 {
            let btn = buttons[i] as! UIButton
            if button.tag == btn.tag {
                selectedDigit = button.tag
                btn.setImage(UIImage(named:"oval_\(i+1)"), for: .normal)
            }
            else {
                btn.setImage(UIImage(named:"free_\(i+1)"), for: .normal)
            }
        }
        nextBtn.isHidden = false
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        if reflection == nil {
            if delegate != nil {
                delegate?.effectAdded(effect: getRating())
            }
            self.backBtnTouched("")
        }
        else {
            let pv:PlanVC = self.storyboard!.instantiateViewController(withIdentifier: "PlanVC") as! PlanVC
            let arr = NSMutableArray()
            arr.add(getRating())
            reflection["effects"] = arr
            pv.reflection = reflection
            self.present(pv, animated: true, completion: nil)
        }
    }
    
    func getRating()->String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy 'at' h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        let dateString = formatter.string(from: Date())
        
        let res = "\(selectedDigit)/10 on \(dateString)"
        return res
    }

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
