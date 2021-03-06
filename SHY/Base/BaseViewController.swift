//
//  BaseViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/7.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var customStatusBar : UIView! = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20 + kXtop()))
    var customNavigationView : UIView! = UIView.init(frame: CGRect(x: 0, y: 20 + kXtop(), width: kScreenWidth, height: 44))
    var titleLabel : UILabel! = nil
    var kTitle = ""
    var hiddenBackBtn = false
    override var title: String? {
        set {
            kTitle = (newValue)!
            if titleLabel == nil {
                titleLabel = UILabel.init(frame: self.customNavigationView.bounds)
                self.customNavigationView.addSubview(titleLabel)
                titleLabel.textAlignment = NSTextAlignment.center
                titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
                titleLabel.textColor = UIColor.grayTwo()
            }
            titleLabel.text = kTitle
        }
        get {
            return kTitle
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.customStatusBar.backgroundColor = UIColor.white
        self.customNavigationView.backgroundColor = UIColor.white
        self.view.addSubview(self.customStatusBar)
        self.view.addSubview(self.customNavigationView)
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        if !self.hiddenBackBtn {
            let backBtn = UIButton.init(frame: CGRect.width(44))
            backBtn.setImage(UIImage.init(named: "hy_back"), for: UIControlState.normal)
            backBtn.adjustImageRect(CGRect(x: 9, y: 13.5, width: 17, height: 17))
            backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
            self.customNavigationView.addSubview(backBtn)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
