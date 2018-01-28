//
//  HomeVC.swift
//  StrategiesApp
//
//  Created by Ahaha on 24.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func paparBtnTouched(_ sender: Any) {
        let lv:ListVC = self.storyboard!.instantiateViewController(withIdentifier: "ListVC") as! ListVC
        self.present(lv, animated: true, completion: nil)
    }
    @IBAction func heartBtnTouched(_ sender: Any) {
        let fv:FavoritesVC = self.storyboard!.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesVC
        self.present(fv, animated: true, completion: nil)
    }
    @IBAction func shieldBtnTouched(_ sender: Any) {
        let cv:CardsPageVC = self.storyboard!.instantiateViewController(withIdentifier: "CardsPageVC") as! CardsPageVC
        self.present(cv, animated: true, completion: nil)
    }
    @IBAction func starBtnTouched(_ sender: Any) {
        let rv:ReflectionsVC = self.storyboard!.instantiateViewController(withIdentifier: "ReflectionsVC") as! ReflectionsVC
        self.present(rv, animated: true, completion: nil)
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
