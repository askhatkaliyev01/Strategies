//
//  InMyLifeVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

@objc protocol InMyLifeDelegate {
    func inMyLifeChanged(inMyLife:String)
}

class InMyLifeVC: UIViewController,UITextViewDelegate {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var textView: UITextView!

    weak var delegate: InMyLifeDelegate?

    var reflection:NSMutableDictionary! = nil
    var textViewText:String! = ""
    var mainDB = MainDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initText()
        textView.becomeFirstResponder()
        textView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    func initText() {
        titleLbl.text = mainDB.translateString(str: "Reflections")
        infoLbl.text = mainDB.translateString(str: "How this strategy of darkness shows itself in my life.")
        textView.text = textViewText
        
        mainDB.setTitleStyle(lbl: titleLbl)
        mainDB.setTitleStyle(lbl: infoLbl)
        mainDB.setTextStyle(lbl: textView)
    }

    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            if reflection == nil {
                if delegate != nil {
                    delegate?.inMyLifeChanged(inMyLife: textView.text)
                }
                self.backBtnTouched("")
            }
            else {
                let ev:EffectVC = self.storyboard!.instantiateViewController(withIdentifier: "EffectVC") as! EffectVC
                reflection["in_my_life"] = textView.text
                ev.reflection = reflection
                self.present(ev, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
