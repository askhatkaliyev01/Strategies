//
//  ListVC.swift
//  StrategiesApp
//
//  Created by Ahaha on 24.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class ListVC: UIViewController,ListTableViewHelperDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var listTableViewHelper:ListTableViewHelper!
    var mainDB:MainDB!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listTableViewHelper = ListTableViewHelper()
        listTableViewHelper.initialize(tableView: tableView)
        listTableViewHelper.delegate = self
        
        mainDB = MainDB()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    // MARK: ListTableViewHelperDelegate
    func tableSelected(withIndex: Int, title: String) {
        if withIndex == 1 {
            let mv:MeetingVC = self.storyboard!.instantiateViewController(withIdentifier: "MeetingVC") as! MeetingVC
            mv.titleText = title
            self.present(mv, animated: true, completion: nil)
        }
        else if withIndex == 10 {
            let sv:SettingsVC = self.storyboard!.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
            self.present(sv, animated: true, completion: nil)
        }
        else {
            let iv:InfoVC = self.storyboard!.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
            iv.elements = mainDB.getInfosArray(forSection: title)
            iv.titleText = title
            self.present(iv, animated: true, completion: nil)
        }
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
