//
//  FavoritesTableViewHelper.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 25.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit
import MGSwipeTableCell

@objc protocol FavoritesTableViewHelperDelegate {
    func tableSelected(cardIndex:Int, isLight:Bool)
}

class FavoritesTableViewHelper: NSObject,UITableViewDelegate,UITableViewDataSource {
    var tableView: UITableView!
    var cells: NSMutableArray!
    var editButtonTouched:Bool! = false
    weak var delegate: FavoritesTableViewHelperDelegate?
    let mainDB:MainDB = MainDB()
    
    func initialize(tableView: UITableView!) {
        self.tableView = tableView
        self.initTableView()
        reloadCells()
    }
    
    func reloadCells() {
        cells = NSMutableArray()
        let arr:NSMutableArray = mainDB.getFavorites()
        for el in arr {
            cells.add(el)
        }
    }
    
    func initTableView() {
        tableView.register(UINib(nibName: "FavoritesCell", bundle: nil), forCellReuseIdentifier: "FavoritesCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.clear
        
        tableView.separatorStyle = .none
    }
    
    
    func deleteFavoriteRow(index:Int){
        let dic:NSDictionary = cells.object(at: index) as! NSDictionary
        let num:String! = dic["number"] as! String
        
        if dic["type"] as! String == "light" {
            mainDB.addLightLiked(num: num)
        }
        else{
            mainDB.addDarkLiked(num: num)
        }
        cells.removeObject(at: index)
        tableView.reloadData()
    }
    
    
    // MARK: - table view delegate
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "FavoritesCell"
        var cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? FavoritesCell)
        if cell == nil {
            cell = FavoritesCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell?.selectionStyle = .none
        cell?.initWithFav(fav: cells.object(at: indexPath.row) as! NSDictionary)
        
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
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dict:NSDictionary! = cells.object(at: indexPath.row) as! NSDictionary
        
        let num:String! = dict["number"] as! String
        let type:String! = dict["type"] as! String
        delegate?.tableSelected(cardIndex: Int(num)!-1, isLight: type == "light")
    }
    
}
