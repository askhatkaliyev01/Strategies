//
//  PlanVC.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 26.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit

@objc protocol PlanDelegate {
    func planChanged(plan:String)
}

class PlanVC: UIViewController,UITextViewDelegate {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: PlanDelegate?

    
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
        infoLbl.text = mainDB.translateString(str: "My action plan for tackling this strategy (remember you can use the corresponding strategy of light as a resource):")
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
                    delegate?.planChanged(plan: textView.text)
                }
                self.backBtnTouched("")
            }
            else {
                self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: {
                    if var topController = UIApplication.shared.keyWindow?.rootViewController {
                        while let presentedViewController = topController.presentedViewController {
                            topController = presentedViewController
                        }
                        
                        let rv:ReflectionVC = self.storyboard!.instantiateViewController(withIdentifier: "ReflectionVC") as! ReflectionVC
                        self.reflection["plan"] = textView.text
                        rv.reflection = self.reflection
                        self.saveReflection()
                        topController.present(rv, animated: true, completion: nil)
                    }
                })
            }

            return false
        }
        return true
    }
    
    func saveReflection() {
        let mainDB = MainDB()
        let arr:NSMutableArray = NSMutableArray.init(array: mainDB.getAllReflections())
        arr.add(reflection)
        mainDB.setReflections(reflections: arr)
    }
}
