//
//  StrategiesTableViewHelper.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit
import MGSwipeTableCell

@objc protocol StrategiesTableViewHelperDelegate {
    func tableSelected(withIndex:Int)
}

class StrategiesTableViewHelper: NSObject,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var cells: NSArray!
    var selectedStrategy:Int = -1
    var mainDB = MainDB()

    weak var delegate: StrategiesTableViewHelperDelegate?
    
    func initialize(tableView: UITableView!) {
        cells = mainDB.getAllDarkSides()
        
        self.tableView = tableView
        self.initTableView()
    }
    
    
    func initTableView() {
        tableView.register(UINib(nibName: "StrategyCell", bundle: nil), forCellReuseIdentifier: "StrategyCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        tableView.separatorStyle = .none
    }
    
    
    
    // MARK: - table view delegate
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "StrategyCell"
        var cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? StrategyCell)
        if cell == nil {
            cell = StrategyCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell?.selectionStyle = .none
        if indexPath.row == selectedStrategy {
            cell?.tickImgV.isHidden = false
        }
        else {
            cell?.tickImgV.isHidden = true
        }
        
        let dic:NSDictionary! = cells.object(at: indexPath.row) as! NSDictionary
        cell?.titleLbl.text = "\(mainDB.translateString(str: "Strategy")) \(indexPath.row+1)"
        cell?.infoLbl.text = dic.object(forKey: "title") as? String
        
        mainDB.setTitleStyle(lbl: (cell?.titleLbl)!)
        mainDB.setTextStyle(lbl: (cell?.infoLbl)!)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < cells.count {
            selectedStrategy = indexPath.row
            delegate?.tableSelected(withIndex: indexPath.row)
        }
    }
}
