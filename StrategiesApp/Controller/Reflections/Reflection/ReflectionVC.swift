//
//  ReflectionVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 26.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class ReflectionVC: UIViewController,InMyLifeDelegate,EffectDelegate,PlanDelegate {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var strategyNameLbl: UILabel!
    @IBOutlet weak var strategyTextLbl: UILabel!
    
    @IBOutlet weak var inMyLifeLbl: UILabel!
    @IBOutlet weak var inMyLifeTextLbl: UILabel!
   
    @IBOutlet weak var effectLbl: UILabel!
    @IBOutlet weak var ratingsHolderLbl: UILabel!
    @IBOutlet weak var ratingsHolderHeightCont: NSLayoutConstraint!
    
    @IBOutlet weak var planLbl: UILabel!
    @IBOutlet weak var planTextLbl: UILabel!

    var reflection:NSMutableDictionary! = nil
    var mainDB = MainDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initText()
        initInfo()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initInfo()
    }
    
    func initText() {
        titleLbl.text = mainDB.translateString(str: "Reflections")
        strategyNameLbl.text = mainDB.translateString(str: "Name of strategy of darkness that trips me up:")
        inMyLifeLbl.text = mainDB.translateString(str: "How this strategy of darkness shows itself in my life.")
        effectLbl.text = mainDB.translateString(str: "How effectively this strategy of darkness works on me on a scale of 0-10:")
        planLbl.text = mainDB.translateString(str: "My action plan for tackling this strategy")
        
        mainDB.setTitleStyle(lbl: titleLbl)
        mainDB.setTitleStyle(lbl: strategyNameLbl)
        mainDB.setTitleStyle(lbl: inMyLifeLbl)
        mainDB.setTitleStyle(lbl: effectLbl)
        mainDB.setTitleStyle(lbl: planLbl)
    }
 
    func initInfo(){
        let strategy = reflection["strategy"] as! NSDictionary
        strategyTextLbl.text = strategy["title"] as? String
        inMyLifeTextLbl.text = reflection["in_my_life"] as? String
        
        mainDB.setTextStyle(lbl: strategyTextLbl)
        mainDB.setTextStyle(lbl: inMyLifeTextLbl)
        
        let effects = reflection["effects"] as! NSArray
        for vv in ratingsHolderLbl.subviews {
            vv.removeFromSuperview()
        }
        var yV:CGFloat = 0.0
        ratingsHolderLbl.text = ""
        for i in 0 ..< effects.count {
            let el:String = effects.object(at: i) as! String
            let lbl = UILabel()
//            lbl.frame = CGRect(x:0,y:0,width:ratingsHolderLbl.frame.size.width,height:0)
            lbl.text = "\(mainDB.translateString(str: "Rating")) \(i+1):"
            mainDB.setBoldTextStyle(lbl: lbl)
            lbl.sizeToFit()
            lbl.frame = CGRect(x:CGFloat(0.0),y:CGFloat(yV),width:lbl.frame.size.width,height:lbl.frame.size.height)
            ratingsHolderLbl.addSubview(lbl)
            
            
            let lbl1 = UILabel()
            //            lbl.frame = CGRect(x:0,y:0,width:ratingsHolderLbl.frame.size.width,height:0)
            lbl1.text = el
            mainDB.setTextStyle(lbl: lbl1)
            lbl1.sizeToFit()
            lbl1.frame = CGRect(x:lbl.frame.size.width+lbl.frame.origin.x+8,y:CGFloat(yV),width:lbl1.frame.size.width,height:lbl1.frame.size.height)
            ratingsHolderLbl.addSubview(lbl1)
            
            
            yV = yV+lbl.frame.size.height+8.0
            
            if i+1 < effects.count {
                let vv = UIView()
                vv.frame = CGRect(x:0,y:yV,width:ratingsHolderLbl.frame.size.width,height:1)
                vv.backgroundColor = Helper.rgba(red: 198, green: 198, blue: 198, alpha: 1)
                ratingsHolderLbl.addSubview(vv)
                yV = yV+8
            }
        }
        ratingsHolderHeightCont.constant = yV
        
        planTextLbl.text = reflection["plan"] as? String
        mainDB.setTextStyle(lbl: planTextLbl)
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editInMyLifeBtnTouched(_ sender: Any) {
        let iv:InMyLifeVC = self.storyboard!.instantiateViewController(withIdentifier: "InMyLifeVC") as! InMyLifeVC
        iv.delegate = self
        iv.textViewText = reflection["in_my_life"] as? String
        self.present(iv, animated: true, completion: nil)
    }
    
    @IBAction func addRatingBtnTouched(_ sender: Any) {
        let ev:EffectVC = self.storyboard!.instantiateViewController(withIdentifier: "EffectVC") as! EffectVC
        ev.delegate = self
        self.present(ev, animated: true, completion: nil)
        
    }
    
    @IBAction func changePlanBtnTouched(_ sender: Any) {
        let pv:PlanVC = self.storyboard!.instantiateViewController(withIdentifier: "PlanVC") as! PlanVC
        pv.delegate = self
        pv.textViewText = reflection["plan"] as? String
        self.present(pv, animated: true, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    
    // Delegates
    func inMyLifeChanged(inMyLife: String) {
        reflection["in_my_life"] = inMyLife
        changeCurrentReflection()
    }
    func effectAdded(effect: String) {
        let arr:NSMutableArray = NSMutableArray.init(array:reflection["effects"] as! NSArray)
        arr.add(effect)
        reflection["effects"] = arr
        changeCurrentReflection()
    }
    func planChanged(plan: String) {
        reflection["plan"] = plan
        changeCurrentReflection()
    }
    
    func changeCurrentReflection() {
        let arr:NSMutableArray = NSMutableArray.init(array: mainDB.getAllReflections())
        let res:NSMutableArray = NSMutableArray()
        for i in 0 ..< arr.count {
            let curD:NSMutableDictionary = NSMutableDictionary.init(dictionary: arr.object(at: i) as! NSDictionary)
            if curD["id"] as! String == reflection["id"] as! String {
                res.add(reflection)
            }
            else {
                res.add(curD)
            }
        }
        mainDB.setReflections(reflections: res)
    }
}
