//
//  StrategiesVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class StrategiesVC: UIViewController,StrategiesTableViewHelperDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    var strategiesTableViewHelper:StrategiesTableViewHelper!
    var mainDB:MainDB!
    var selectedStrategy:Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        strategiesTableViewHelper = StrategiesTableViewHelper()
        strategiesTableViewHelper.initialize(tableView: tableView)
        strategiesTableViewHelper.delegate = self
        
        mainDB = MainDB()
        initText()
        
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1).cgColor
        nextBtn.isHidden = true
    }
    func initText() {
        nextBtn.setTitle(mainDB.translateString(str: "Next"), for: .normal)
        titleLbl.text = mainDB.translateString(str: "Reflections")
        infoLbl.text = mainDB.translateString(str: "Name of strategy of darkness that trips me up:")
        
        mainDB.setTitleStyle(lbl: titleLbl)
        mainDB.setTitleStyle(lbl: infoLbl)
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }

    @IBAction func nextButtonTouched(_ sender: Any) {
        let iv:InMyLifeVC = self.storyboard!.instantiateViewController(withIdentifier: "InMyLifeVC") as! InMyLifeVC
        let dd = NSMutableDictionary()
        dd["strategy"] = mainDB.getDarkSide(index: selectedStrategy)
        dd["id"] = "\(selectedStrategy+1)"
        iv.reflection = dd
        self.present(iv, animated: true, completion: nil)
    }
    
    func random(length: Int = 20) -> String {
        let base:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(40)
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    // MARK: StrategiesTableViewHelperDelegate
    func tableSelected(withIndex: Int) {
        selectedStrategy = withIndex
        tableView.reloadData()
        nextBtn.isHidden = false
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

}
