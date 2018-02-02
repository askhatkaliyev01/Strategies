//
//  MainDB.swift
//  UniversitiesOfTheSpiritApp
//
//  Created by Askhat Kaliyev on 12.10.17.
//  Copyright © 2017 Kumara Creations. All rights reserved.
//

import UIKit

class MainDB: NSObject {
    var plistDict:NSDictionary!

    override init() {
        plistDict = LanguageChanger.sharedInstance.getDictForLanguage(ln: MainDB.getCurrentLanguage())
    }
    
    
    
    
    func getInfosArray(forSection:String) -> NSMutableArray {
        let dic:NSDictionary = plistDict.object(forKey: "infos") as! NSDictionary
   
        let arr:NSMutableArray = dic.object(forKey: forSection) as! NSMutableArray
        return arr
    }
    
    func getBasicInfosArray() -> NSMutableArray {
        let arr:NSMutableArray = plistDict.object(forKey: "basic_infos") as! NSMutableArray
        return arr
    }
    
    
    func getDarkSide(index:Int) -> NSDictionary {
        let arr:NSArray = plistDict.object(forKey: "dark_sides") as! NSArray
        return arr[index] as! NSDictionary
    }
    func getLightSide(index:Int) -> NSDictionary {
        let arr:NSArray = plistDict.object(forKey: "light_sides") as! NSArray
        return arr[index] as! NSDictionary
    }
    func getAllDarkSides() -> NSArray {
        let arr:NSArray = plistDict.object(forKey: "dark_sides") as! NSArray
        return arr
    }
    func getAllLightSides() -> NSArray {
        let arr:NSArray = plistDict.object(forKey: "light_sides") as! NSArray
        return arr
    }
    
    
    func setBigText(isBig:Bool) {
        if isBig {
            UserDefaults.standard.set("1", forKey: "BIG_TEXT_SIZE")
        }
        else {
            UserDefaults.standard.set("0", forKey: "BIG_TEXT_SIZE")
        }
        UserDefaults.standard.synchronize()
    }
    
    
    func isTextBig() -> Bool {
        if let obj:String = UserDefaults.standard.object(forKey: "BIG_TEXT_SIZE") as? String {
            if obj == "1" {
                return true
            }
        }
        return false
    }
    
    func setDontShowAgain(isShow:Bool) {
        if isShow {
            UserDefaults.standard.set("1", forKey: "DONT_SHOW_AGAIN")
        }
        else {
            UserDefaults.standard.set("0", forKey: "DONT_SHOW_AGAIN")
        }
        UserDefaults.standard.synchronize()
    }
    
    
    func isDontShowAgain() -> Bool {
        if let obj:String = UserDefaults.standard.object(forKey: "DONT_SHOW_AGAIN") as? String {
            if obj == "1" {
                return true
            }
        }
        return false
    }
    
    
    
    static func setCurrentLanguage(lang:String) {
        UserDefaults.standard.set(lang, forKey: "CURRENT_LANGUAGE")
        UserDefaults.standard.synchronize()
    }
    static func getCurrentLanguage() -> String {
        if let obj:String = UserDefaults.standard.object(forKey: "CURRENT_LANGUAGE") as? String {
            return obj
        }
        return "en"
    }
    
    func setReflections(reflections:NSArray) {
        UserDefaults.standard.set(reflections, forKey: "ALL_REFLECTIONS")
        UserDefaults.standard.synchronize()
    }

    func getAllReflections() -> NSArray {
        if let obj:NSArray = UserDefaults.standard.object(forKey: "ALL_REFLECTIONS") as? NSArray {
            return obj
        }
        return NSArray()
    }
    
    func setFavorites(favs:NSDictionary) {
        UserDefaults.standard.set(favs, forKey: "ALL_FAVORITES")
        UserDefaults.standard.synchronize()
    }
    
    func getAllFavorites() -> NSDictionary {
        if let obj:NSDictionary = UserDefaults.standard.object(forKey: "ALL_FAVORITES") as? NSDictionary {
            return obj
        }
        return NSDictionary()
    }
    func getFavorites() -> NSMutableArray {
        let arr = NSMutableArray()
        let dict = getAllFavorites()
        for num:Int in 1 ... 33 {
            var st = "light"
            if dict["\(st)+\(num)"] != nil && dict["\(st)+\(num)"] as! String == "added" {
                let d = NSMutableDictionary(dictionary: getLightSide(index: num-1))
                d["type"] = st
                arr.add(d)
            }
            st = "dark"
            if dict["\(st)+\(num)"] != nil && dict["\(st)+\(num)"] as! String == "added" {
                let d = NSMutableDictionary(dictionary: getLightSide(index: num-1))
                d["type"] = st
                arr.add(d)
            }
        }
        return arr
    }
    func isDarkLiked(num:String) -> Bool {
        let dict = getAllFavorites()
        if dict["dark+\(num)"] != nil && dict["dark+\(num)"] as! String == "added" {
            return true
        }
        return false
    }
    func isLightLiked(num:String) -> Bool {
        let dict = getAllFavorites()
        if dict["light+\(num)"] != nil && dict["light+\(num)"] as! String == "added" {
            return true
        }
        return false
    }
    func addDarkLiked(num:String) {
        let dict:NSMutableDictionary = NSMutableDictionary.init(dictionary: getAllFavorites())
        
        if dict["dark+\(num)"] != nil && dict["dark+\(num)"] as! String == "added" {
            dict["dark+\(num)"] = "none"
        }
        else {
            dict["dark+\(num)"] = "added"
        }
        setFavorites(favs: dict)
    }
    func addLightLiked(num:String) {
        let dict:NSMutableDictionary = NSMutableDictionary.init(dictionary: getAllFavorites())
        
        if dict["light+\(num)"] != nil && dict["light+\(num)"] as! String == "added" {
            dict["light+\(num)"] = "none"
        }
        else {
            dict["light+\(num)"] = "added"
        }
        setFavorites(favs: dict)
    }
    
    
    
    func translateString(str:String) -> String {
        let dict = plistDict["WORDS"] as! NSDictionary
        return dict[str] as! String
    }
    // FONTS
    func fontSizeAdder()->CGFloat {
        if isTextBig() {
            return 0
        }
        return -3
    }
    func setTitleStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "ACaslonPro-Semibold", size: 22+fontSizeAdder())
    }
    func setTextStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "ACaslonPro-Regular", size: 18+fontSizeAdder())
    }
    func setTextStyle(lbl:UITextView) {
        lbl.font = UIFont(name: "ACaslonPro-Regular", size: 18+fontSizeAdder())
    }
    func setBoldTextStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "ACaslonPro-Bold", size: 18+fontSizeAdder())
    }
    func setLightTitleStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "ACaslonPro-Bold", size: 22+fontSizeAdder())
        lbl.textColor = Helper.rgba(red: 111, green: 19, blue: 67, alpha: 1)
    }
    func setLightNumberStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "Times New Roman", size: 30+fontSizeAdder())
        lbl.textColor = Helper.rgba(red: 111, green: 19, blue: 67, alpha: 1)
    }
    func setDarkTitleStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "Skewer-Bold", size: 22+fontSizeAdder())
        lbl.textColor = Helper.rgba(red: 1, green: 43, blue: 65, alpha: 1)
    }
    func setDarkNumberStyle(lbl:UILabel) {
        lbl.font = UIFont(name: "Rangoon", size: 30+fontSizeAdder())
        lbl.textColor = Helper.rgba(red: 89, green: 66, blue: 43, alpha: 1)
    }
    
    
    static func getCurrentLightHtml() -> String {
        var fileName = "Light_html_"
        if MainDB.getCurrentLanguage() == "sp" {
            fileName = "SpLight_html_"
        }
        else if MainDB.getCurrentLanguage() == "ru" {
            fileName = "RuLight_html_"
        }
        else if MainDB.getCurrentLanguage() == "po" {
            fileName = "PoLight_html_"
        }
        return fileName
    }
    static func getCurrentDarkHtml() -> String {
        var fileName = "Dark_html_"
        if MainDB.getCurrentLanguage() == "sp" {
            fileName = "SpDark_html_"
        }
        else if MainDB.getCurrentLanguage() == "ru" {
            fileName = "RuDark_html_"
        }
        else if MainDB.getCurrentLanguage() == "po" {
            fileName = "PoDark_html_"
        }
        return fileName
    }
}
