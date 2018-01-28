//
//  Helper.swift
//  UniversitiesOfTheSpiritApp
//
//  Created by Ahaha on 12.10.17.
//  Copyright © 2017 Kumara Creations. All rights reserved.
//

import UIKit

class Helper: NSObject {
    static let scn_width = UIScreen.main.bounds.size.width
    static let scn_height = UIScreen.main.bounds.size.height
    static let scn_center:CGPoint = CGPoint(x:scn_width/2, y:scn_height/2)
    
    
    static func rgba(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat) -> UIColor {
        return UIColor(red:red/255.0, green:green/255.0, blue:blue/255.0, alpha:alpha)
    }
    
    
//    static func zOrStr(any:Any?, key:String) -> String {
//        if any != nil , let kAny: [AnyHashable:Any] = any as! [AnyHashable : Any]? {
//            return HelperFunctions.zeroStringOrString(fromObj:kAny[key])
//        }
//        return "0"
//    }
//    
//    static func fOrStr(any:Any?, key:String) -> String {
//        if any != nil , let kAny: [AnyHashable:Any] = any as! [AnyHashable : Any]? {
//            return HelperFunctions.freeStringOrString(fromObj:kAny[key])
//        }
//        return ""
//    }
    
}
