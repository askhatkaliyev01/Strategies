//
//  SettingsVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 24.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var fontLbl: UILabel!
    
    @IBOutlet weak var engLbl: UILabel!
    @IBOutlet weak var spnLbl: UILabel!
    @IBOutlet weak var ruLbl: UILabel!
    @IBOutlet weak var porLbl: UILabel!
    
    @IBOutlet weak var engS: SwitchButton!
    @IBOutlet weak var spnS: SwitchButton!
    @IBOutlet weak var ruS: SwitchButton!
    @IBOutlet weak var porS: SwitchButton!
    
    @IBOutlet weak var textSizeS: SwitchButton!
    
    var mainDB:MainDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainDB = MainDB()
        
        // Do any additional setup after loading the view.
        initText()
        changeSwitch()
        
        engS.setOff()
        spnS.setOff()
        ruS.setOff()
        porS.setOff()
        
        switch MainDB.getCurrentLanguage() {
        case "en":
            engS.setOn()
        case "sp":
            spnS.setOn()
        case "ru":
            ruS.setOn()
        case "po":
            porS.setOn()
        default:
            engS.setOn()
        }
    }
    
    func changeSwitch() {
        if mainDB.isTextBig() {
            textSizeS.setOn()
        }
        else {
            textSizeS.setOff()
        }
    }
    
    func initText() {
        titleLbl.text = mainDB.translateString(str: "Settings")
        langLbl.text = mainDB.translateString(str: "Language")
        fontLbl.text = mainDB.translateString(str: "Font size")
        
        engLbl.text = mainDB.translateString(str: "English")
        spnLbl.text = mainDB.translateString(str: "Spanish")
        ruLbl.text = mainDB.translateString(str: "Russian")
        porLbl.text = mainDB.translateString(str: "Portuguese")
        
        mainDB.setTitleStyle(lbl: titleLbl)
        mainDB.setTitleStyle(lbl: langLbl)
        mainDB.setTitleStyle(lbl: fontLbl)
        
        mainDB.setTextStyle(lbl: engLbl)
        mainDB.setTextStyle(lbl: spnLbl)
        mainDB.setTextStyle(lbl: ruLbl)
        mainDB.setTextStyle(lbl: porLbl)
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func engSChanged(_ sender: Any) {
        if !engS.isOn {
            engS.setOn()
            spnS.setOff()
            ruS.setOff()
            porS.setOff()
            MainDB.setCurrentLanguage(lang: "en")
            initText()
        }
    }

    @IBAction func spnSChanged(_ sender: Any) {
        if !spnS.isOn {
            spnS.setOn()
            engS.setOff()
            ruS.setOff()
            porS.setOff()
            MainDB.setCurrentLanguage(lang: "sp")
            initText()
        }
    }
    
    @IBAction func ruSChanged(_ sender: Any) {
        if !ruS.isOn {
            ruS.setOn()
            spnS.setOff()
            engS.setOff()
            porS.setOff()
            MainDB.setCurrentLanguage(lang: "ru")
            initText()
        }
    }
    
    @IBAction func porSChanged(_ sender: Any) {
        if !porS.isOn {
            porS.setOn()
            spnS.setOff()
            ruS.setOff()
            engS.setOff()
            MainDB.setCurrentLanguage(lang: "po")
            initText()
        }
    }
    
    @IBAction func textSizeSChanged(_ sender: Any) {
        if textSizeS.isOn {
            textSizeS.setOff()
            mainDB.setBigText(isBig: false)
        }
        else {
            textSizeS.setOn()
            mainDB.setBigText(isBig: true)
        }
        initText()
    }
}
