//
//  ReflectionsTableViewHelper.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit
import MGSwipeTableCell

@objc protocol ReflectionsTableViewHelperDelegate {
    func tableSelected(reflection:NSMutableDictionary)
}

class ReflectionsTableViewHelper: NSObject,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var cells: NSMutableArray!
    var editButtonTouched:Bool! = false
    weak var delegate: ReflectionsTableViewHelperDelegate?
    var mainDB:MainDB = MainDB()
    
    func initialize(tableView: UITableView!) {
        cells = NSMutableArray.init(array: mainDB.getAllReflections())
        
        self.tableView = tableView
        self.initTableView()
    }
    
    func updateCells() {
        cells = NSMutableArray.init(array: mainDB.getAllReflections())
        tableView.reloadData()
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: "ReflectionCell", bundle: nil), forCellReuseIdentifier: "ReflectionCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        tableView.separatorStyle = .none
    }
    
    
    func deleteFavoriteRow(index:Int){
        print("\(index) Convenience callback for swipe buttons!")
        cells.removeObject(at: index)
        tableView.reloadData()
        mainDB.setReflections(reflections: cells)
    }
    
    
    // MARK: - table view delegate
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "ReflectionCell"
        var cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? ReflectionCell)
        if cell == nil {
            cell = ReflectionCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell?.selectionStyle = .none
        cell?.initReflection(ref: cells.object(at: indexPath.row) as! NSDictionary)
        
        mainDB.setTitleStyle(lbl: (cell?.titleLbl)!)
        mainDB.setTextStyle(lbl: (cell?.infoLbl)!)
        
        if editButtonTouched {
            //configure left buttons
            let delBtn = MGSwipeButton(title: mainDB.translateString(str: "Delete"), icon: nil, backgroundColor: Helper.rgba(red: 255, green: 51, blue: 43, alpha: 1)) {
                (sender: MGSwipeTableCell!) -> Bool in
                self.deleteFavoriteRow(index: indexPath.row)
                return true
            }
            let del1Btn = MGSwipeButton(title: "", icon: UIImage(named:"delete"), backgroundColor: .clear) {
                (sender: MGSwipeTableCell!) -> Bool in
                self.deleteFavoriteRow(index: indexPath.row)
                return true
            }
            
            cell?.leftButtons = [del1Btn]
            cell?.rightButtons = [delBtn]
            cell?.leftSwipeSettings.transition = .drag
            cell?.rightSwipeSettings.transition = .drag
        }
        else {
            cell?.leftButtons = []
            cell?.rightButtons = []
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < cells.count {
            if delegate != nil {
                let ref:NSMutableDictionary = NSMutableDictionary.init(dictionary: cells.object(at: indexPath.row) as! NSDictionary)
                delegate?.tableSelected(reflection: ref)
            }
        }
    }
}
