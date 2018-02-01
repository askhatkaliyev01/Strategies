//
//  LanguageChanger.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 29.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class LanguageChanger: NSObject {
    static let sharedInstance = LanguageChanger()
    
    func getDictForLanguage(ln:String)->NSDictionary {
        var fileName = "DBase"
        
        if MainDB.getCurrentLanguage() == "sp" {
            fileName = "SpDBase"
        }
        else if MainDB.getCurrentLanguage() == "ru" {
            fileName = "RuDBase"
        }
        else if MainDB.getCurrentLanguage() == "po" {
            fileName = "PoDBase"
        }
        
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        return myDict!
    }
}
