//
//  InfoVC.swift
//  StrategiesApp
//
//  Created by Yerassyl Yerlanov on 24.01.2018.
//  Copyright © 2018 AceLight. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var titleText:String?
    var elements: NSMutableArray?
    var mainDB = MainDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLbl.text = titleText!
        
        mainDB.setTitleStyle(lbl: titleLbl)
        
        initElements()
    }

    func initElements() {
        var yPos = 0.0
        
        for i in 0 ... (elements?.count)!-1 {
            var st:String! = elements?.object(at: i) as! String
            
            if st.range(of: "<IMAGE>") != nil {
                st = st.replacingOccurrences(of: "<IMAGE>", with: "")
                let img:UIImage = UIImage(named:st)!
                let imgV:UIImageView = UIImageView()
                imgV.image = img
                let wid = Double(Helper.scn_width-92.0)
                let hei = wid/Double(img.size.width) * Double(img.size.height)
                imgV.frame = CGRect(x:46.0, y:yPos, width:wid, height:hei)

                yPos = yPos + hei + 16.0
                scrollView.addSubview(imgV)
                scrollView.contentSize = CGSize(width:Double(Helper.scn_width), height:yPos)
            }
            else {
                let lbl:UILabel = UILabel()
                
                lbl.frame = CGRect(x:16.0, y:yPos, width:Double(Helper.scn_width-32.0), height:0.0)
                mainDB.setTextStyle(lbl: lbl)
                lbl.numberOfLines = 0
                
                if st.range(of: "<BOLD>") != nil {
                    st = st.replacingOccurrences(of: "<BOLD>", with: "")
                    mainDB.setBoldTextStyle(lbl: lbl)
                    lbl.textAlignment = .center
                }
                
                lbl.textColor = Helper.rgba(red: 3, green: 40, blue: 58, alpha: 1)
                lbl.text = st
                lbl.sizeToFit()
                lbl.frame = CGRect(x:16.0, y:yPos, width:Double(Helper.scn_width-32.0), height:Double(lbl.frame.size.height))
                yPos = yPos + Double(lbl.frame.size.height) + 16.0
                scrollView.addSubview(lbl)
                scrollView.contentSize = CGSize(width:Double(Helper.scn_width), height:yPos)
            }
        }
    }
    
    @IBAction func backBtnTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override var shouldAutorotate: Bool {
        return false
    }
}
