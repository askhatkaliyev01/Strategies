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
    
    var darkShown:Bool = true
    var darkSide:SideView! = nil
    var lightSide:SideView! = nil
    var mainDB:MainDB! = nil
    
    @IBOutlet weak var leftImgV: UIImageView!
    @IBOutlet weak var rightImgV: UIImageView!
    
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
            leftImgV.isHidden = true
            rightImgV.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetUnscrollable"), object: nil)
        }
        else {
            lightSide.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetScrollable"), object: nil)
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lightSide.goTop()
        darkSide.goTop()
    }
    
    @IBAction func upBtnTouched(_ sender: Any) {
        if darkShown {
            darkShown = false
            darkSide.isHidden = true
            lightSide.isHidden = false
            
            leftImgV.isHidden = true
            rightImgV.isHidden = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetUnscrollable"), object: nil)
        }
        else {
            darkShown = true
            darkSide.isHidden = false
            lightSide.isHidden = true
            
            leftImgV.isHidden = false
            rightImgV.isHidden = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetScrollable"), object: nil)
        }
        lightSide.goTop()
        darkSide.goTop()
    }
    
    // MARK: - SideViewDelegate
    func homeTouched() {
        self.dismiss(animated: true, completion: nil)
    }
    func likeTouched() {
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
