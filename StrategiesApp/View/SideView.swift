//
//  SideView.swift
//  StrategiesApp
//
//  Created by Askhat Kaliyev on 26.01.2018.
//  Copyright © 2018 AKKU. All rights reserved.
//

import UIKit

@objc protocol SideViewDelegate {
    func likeTouched()
    func homeTouched()
}


class SideView: UIView,UIWebViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeImgV: UIImageView!
    @IBOutlet weak var backImgV: UIImageView!
    
    
    weak var delegate: SideViewDelegate?
    var webView:UIWebView! = nil
    var didDownloaded = false
    var sideInfo:NSDictionary! = nil
    var mainDB:MainDB! = MainDB()
    var isLight = false
    
    class func instanceFromNib() -> SideView {
        let gV:SideView = UINib(nibName: "SideView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SideView
        gV.frame = CGRect(x:0,y:0,width:Helper.scn_width,height:Helper.scn_height)
        
        return gV
    }
    
    @IBAction func heartBtnTouched(_ sender: Any) {
        
        let num:String! = sideInfo["number"] as! String
        
        if isLight {
            mainDB.addLightLiked(num: num)
        }
        else {
            mainDB.addDarkLiked(num: num)
        }

        checkIfLiked()
        
        if delegate != nil {
            delegate?.likeTouched()
        }
    }

    @IBAction func homeBtnTouched(_ sender: Any) {
        if delegate != nil {
            delegate?.homeTouched()
        }
    }
    
    
    func initLightSide(info:NSDictionary){
        isLight = true
        sideInfo = info
        let offs:CGFloat = 30.0
        
        let countLbl = UILabel()
        countLbl.text = "\(info["number"]!)"
        mainDB.setLightNumberStyle(lbl: countLbl)
        countLbl.sizeToFit()
        countLbl.frame = CGRect(x:Helper.scn_width-offs-countLbl.frame.size.width,y:0,width:countLbl.frame.size.width,height:countLbl.frame.size.height)
        scrollView.addSubview(countLbl)
        
        
        let imgWid = Helper.scn_width-(2.0*offs)
//        1125 × 648
        let imgHei = (imgWid/1125.0)*648.0
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        let number = String(format: "Light_%02d",  Int("\(info["number"]!)")!)
        imgV.image = UIImage(named:number)
        imgV.frame = CGRect(x:offs,y:countLbl.frame.origin.y+countLbl.frame.size.height+12,width:imgWid,height:imgHei)
        scrollView.addSubview(imgV)
        
        
        let titleOf:CGFloat = 50.0
        let titleLbl = UILabel()
        titleLbl.textAlignment = .center
        titleLbl.frame = CGRect(x:titleOf,y:0.0,width:Helper.scn_width-CGFloat(2.0*titleOf),height:0.0)
        titleLbl.text = "\(info["title"]!)"
        titleLbl.numberOfLines = 4
        mainDB.setLightTitleStyle(lbl: titleLbl)
        titleLbl.sizeToFit()
        titleLbl.frame = CGRect(x:titleOf,y:imgV.frame.origin.y+imgV.frame.size.height+12.0,width:Helper.scn_width-CGFloat(2.0*titleOf),height:titleLbl.frame.size.height)
        scrollView.addSubview(titleLbl)
  
        
        let path:String = Bundle.main.path(forResource: "Light_html_01", ofType: "html")!
        let readHandle:FileHandle = FileHandle.init(forReadingAtPath: path)!
        var htmlString:String = String.init(data: readHandle.readDataToEndOfFile(), encoding:String.Encoding.utf8)!
        if mainDB.isTextBig() {
            htmlString = htmlString.replacingOccurrences(of: "Normal_html", with: "Big_html")
        }

        webView = UIWebView()
        let webY:CGFloat = titleLbl.frame.origin.y+titleLbl.frame.size.height+12.0
        let webH:CGFloat = Helper.scn_height-webY-16.0
        webView.frame = CGRect(x:offs,y:webY,width:Helper.scn_width-2*offs,height:webH)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.delegate = self
        webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        scrollView.addSubview(webView)
        
        scrollView.contentSize = CGSize(width:Helper.scn_width,height:webView.frame.origin.y+webView.frame.size.height+16.0)
        checkIfLiked()
    }
    
    func checkIfLiked(){
        likeImgV.image = UIImage(named:"Heart_Empty_icon")
        let num:String = sideInfo["number"] as! String
        
        if (isLight &&  mainDB.isLightLiked(num: num)) || (!isLight && mainDB.isDarkLiked(num: num)) {
            likeImgV.image = UIImage(named:"Heart_Cards_Full")
        }
    }
    
    func initDarkSide(info:NSDictionary){
        backImgV.image = UIImage(named:"ST_BG_Dark_Side")
        sideInfo = info
        let offs:CGFloat = 30.0
        
        let countLbl = UILabel()
        countLbl.text = "\(info["number"]!)"
        mainDB.setDarkNumberStyle(lbl: countLbl)
        countLbl.sizeToFit()
        countLbl.frame = CGRect(x:Helper.scn_width-offs-countLbl.frame.size.width,y:0,width:countLbl.frame.size.width,height:countLbl.frame.size.height)
        scrollView.addSubview(countLbl)
        
        
        let imgWid = Helper.scn_width-(2.0*offs)
        //        1125 × 648
        let imgHei = (imgWid/1125.0)*648.0
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        let number = String(format: "Dark_%02d",  Int("\(info["number"]!)")!)
        imgV.image = UIImage(named:number)
        imgV.frame = CGRect(x:offs,y:countLbl.frame.origin.y+countLbl.frame.size.height+12,width:imgWid,height:imgHei)
        scrollView.addSubview(imgV)
        
        
        let titleOf:CGFloat = 50.0
        let titleLbl = UILabel()
        titleLbl.textAlignment = .center
        titleLbl.frame = CGRect(x:titleOf,y:0.0,width:Helper.scn_width-CGFloat(2.0*titleOf),height:0.0)
        titleLbl.text = "\(info["title"]!)"
        titleLbl.numberOfLines = 4
        mainDB.setDarkTitleStyle(lbl: titleLbl)
        titleLbl.sizeToFit()
        titleLbl.frame = CGRect(x:titleOf,y:imgV.frame.origin.y+imgV.frame.size.height+12.0,width:Helper.scn_width-CGFloat(2.0*titleOf),height:titleLbl.frame.size.height)
        scrollView.addSubview(titleLbl)
        
        
        let path:String = Bundle.main.path(forResource: "Dark_html_01", ofType: "html")!
        let readHandle:FileHandle = FileHandle.init(forReadingAtPath: path)!
        var htmlString:String = String.init(data: readHandle.readDataToEndOfFile(), encoding:String.Encoding.utf8)!
        if mainDB.isTextBig() {
            htmlString = htmlString.replacingOccurrences(of: "Normal_html", with: "Big_html")
        }
        
        
        webView = UIWebView()
        let webY:CGFloat = titleLbl.frame.origin.y+titleLbl.frame.size.height+12.0
        let webH:CGFloat = Helper.scn_height-webY-16.0
        webView.frame = CGRect(x:offs,y:webY,width:Helper.scn_width-2*offs,height:webH)
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.delegate = self
        webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        scrollView.addSubview(webView)
        
        scrollView.contentSize = CGSize(width:Helper.scn_width,height:webView.frame.origin.y+webView.frame.size.height+16.0)
        checkIfLiked()
    }
    
    func updateWebViewFrame() {
        if webView != nil && didDownloaded == true {
            webView.frame.size.height = 1
            webView.frame.size = webView.sizeThatFits(.zero)
            webView.scrollView.isScrollEnabled=false;
            webView.frame.size.height = webView.scrollView.contentSize.height
            webView.scalesPageToFit = true
            
            scrollView.contentSize = CGSize(width:Helper.scn_width,height:webView.frame.origin.y+webView.frame.size.height+16.0)
        }
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        didDownloaded = true
        updateWebViewFrame()
    }

}
