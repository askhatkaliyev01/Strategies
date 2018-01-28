//
//  ListTableViewHelper.swift
//  StrategiesApp
//
//  Created by Askhat on 24.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit

@objc protocol ListTableViewHelperDelegate {
    func tableSelected(withIndex:Int, title:String)
}


class ListTableViewHelper: NSObject,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var cells: NSMutableArray!
    weak var delegate: ListTableViewHelperDelegate?
    var mainDB = MainDB()
    
    func initialize(tableView: UITableView!) {
        cells = NSMutableArray()
        cells.add(mainDB.translateString(str: "How to use this app"))
        cells.add(mainDB.translateString(str: "Meeting the characters"))
        cells.add(mainDB.translateString(str: "Dark perspective"))
        cells.add(mainDB.translateString(str: "Light perspective"))
        cells.add(mainDB.translateString(str: "Applying the app"))
        cells.add(mainDB.translateString(str: "Getting Serious"))
        cells.add(mainDB.translateString(str: "Recommended reading"))
        cells.add(mainDB.translateString(str: "Gloassary"))
        cells.add(mainDB.translateString(str: "About Kumara Creations"))
        cells.add(mainDB.translateString(str: "Legal"))
        cells.add(mainDB.translateString(str: "Settings"))
        
        
        self.tableView = tableView
        self.initTableView()
    }
    
    
    func initTableView() {
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.register(UINib(nibName: "KumaraCell", bundle: nil), forCellReuseIdentifier: "KumaraCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        tableView.separatorStyle = .none
    }
    
    
    
    // MARK: - table view delegate
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.row == cells.count {
            let CellIdentifier = "KumaraCell"
            var cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? KumaraCell)
            if cell == nil {
                cell = KumaraCell(style: .default, reuseIdentifier: CellIdentifier)
            }
            cell?.selectionStyle = .none
            return cell!
        }
        else {
            let CellIdentifier = "ListCell"
            var cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? ListCell)
            if cell == nil {
                cell = ListCell(style: .default, reuseIdentifier: CellIdentifier)
            }
            cell?.selectionStyle = .none
            
            cell?.initWithTitle(title: cells.object(at: indexPath.row) as! String)
            mainDB.setTitleStyle(lbl: (cell?.titleTextLbl)!)
            
            
            
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == cells.count {
            return 80.0
        }
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < cells.count {
            delegate?.tableSelected(withIndex: indexPath.row, title: cells.object(at: indexPath.row) as! String)
        }
    }
}
