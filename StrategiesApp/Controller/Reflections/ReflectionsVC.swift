//
//  ReflectionsVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class ReflectionsVC: UIViewController,ReflectionsTableViewHelperDelegate,GettingSeriousViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomDivV: UIView!
    
    var editButtonTouched:Bool! = false
    var reflectionsTableViewHelper:ReflectionsTableViewHelper!
    var mainDB:MainDB!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        reflectionsTableViewHelper = ReflectionsTableViewHelper()
        reflectionsTableViewHelper.initialize(tableView: tableView)
        reflectionsTableViewHelper.delegate = self
        
        
        tableView.isHidden = true
        addButton.isHidden = true
        doneButton.isHidden = true
        bottomDivV.isHidden = true
        
        mainDB = MainDB()
        initText()
        if mainDB.isDontShowAgain() == false {
            let gsV:GettingSeriousView = GettingSeriousView.instanceFromNib()
            gsV.firstInit()
            view.addSubview(gsV)
            gsV.delegate = self
        }
        else {
            self.nextTouched(with: 1)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reflectionsTableViewHelper.updateCells()
    }
    func initText() {
        doneButton.setTitle(mainDB.translateString(str: "Edit"), for: .normal)
        titleLbl.text = mainDB.translateString(str: "Reflections")

        mainDB.setTitleStyle(lbl: titleLbl)
        doneButton.titleLabel?.font = UIFont(name: "ACaslonPro-Regular", size: 18)
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func doneButtonTouched(_ sender: Any) {
        if editButtonTouched == false {
            doneButton.setTitle("Done", for: .normal)
            editButtonTouched = true
        }
        else {
            doneButton.setTitle("Edit", for: .normal)
            editButtonTouched = false
        }
        reflectionsTableViewHelper.editButtonTouched = editButtonTouched
        tableView.reloadData()
    }
    @IBAction func addButtonTouched(_ sender: Any) {
        let sv:StrategiesVC = self.storyboard!.instantiateViewController(withIdentifier: "StrategiesVC") as! StrategiesVC
        self.present(sv, animated: true, completion: nil)
    }
    
    // MARK: ReflectionsTableViewHelperDelegate
    func tableSelected(reflection: NSMutableDictionary) {
        let rv:ReflectionVC = self.storyboard!.instantiateViewController(withIdentifier: "ReflectionVC") as! ReflectionVC
        rv.reflection = reflection
        self.present(rv, animated: true, completion: nil)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }


    // MARK: GettingSeriousViewDelegate
    func nextTouched(with: Int) {
        tableView.isHidden = false
        addButton.isHidden = false
        doneButton.isHidden = false
        bottomDivV.isHidden = false
    }
}
