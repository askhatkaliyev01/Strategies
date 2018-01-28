//
//  FavoritesVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController,FavoritesTableViewHelperDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var editButtonTouched:Bool! = false
    var favoritesTableViewHelper:FavoritesTableViewHelper!
    var mainDB:MainDB!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        favoritesTableViewHelper = FavoritesTableViewHelper()
        favoritesTableViewHelper.initialize(tableView: tableView)
        favoritesTableViewHelper.delegate = self
        
        mainDB = MainDB()
        initText()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritesTableViewHelper.reloadCells()
        tableView.reloadData()
    }
    func initText() {
        doneButton.setTitle(mainDB.translateString(str: "Edit"), for: .normal)
        titleLbl.text = mainDB.translateString(str: "Favorites")
        
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
        favoritesTableViewHelper.editButtonTouched = editButtonTouched
        tableView.reloadData()
    }
    
    
    // MARK: FavoritesTableViewHelperDelegate
    func tableSelected(cardIndex: Int, isLight: Bool) {

        let cv:CardsPageVC = self.storyboard!.instantiateViewController(withIdentifier: "CardsPageVC") as! CardsPageVC
        cv.isLight = isLight
        cv.currentIndex = cardIndex
        self.present(cv, animated: true, completion: nil)
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

}
