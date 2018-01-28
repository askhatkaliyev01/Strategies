//
//  CardVC.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 25.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

class CardVC: UIViewController,SideViewDelegate {

    var cardIndex:Int! = 0
    
    var darkShown:Bool = false
    var darkSide:SideView! = nil
    var lightSide:SideView! = nil
    var mainDB:MainDB! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        mainDB = MainDB()
        
        darkSide = SideView.instanceFromNib()
        lightSide = SideView.instanceFromNib()
        
        self.view.insertSubview(darkSide, at: 0)
        self.view.insertSubview(lightSide, at: 0)
        darkSide.delegate = self
        lightSide.delegate = self
        
        darkSide.initDarkSide(info: mainDB.getDarkSide(index: cardIndex))
        lightSide.initLightSide(info: mainDB.getLightSide(index: cardIndex))


        if !darkShown {
            darkSide.isHidden = true
        }
        else {
            lightSide.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lightSide.updateWebViewFrame()
        darkSide.updateWebViewFrame()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.lightSide.updateWebViewFrame()
        })
    }
    
    @IBAction func upBtnTouched(_ sender: Any) {
        if darkShown {
            darkShown = false
            darkSide.isHidden = true
            lightSide.isHidden = false
        }
        else {
            darkShown = true
            darkSide.isHidden = false
            lightSide.isHidden = true
        }
    }
    
    // MARK: - SideViewDelegate
    func homeTouched() {
        self.dismiss(animated: true, completion: nil)
    }
    func likeTouched() {
        
    }
}
