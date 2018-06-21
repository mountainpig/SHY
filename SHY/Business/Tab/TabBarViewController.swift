//
//  TabBarViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/7.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let timelineViewController = TimelineViewController()
    let addressBookViewController = AddressBookViewController()
    let meViewController = MeViewController()
    var selectBtn : UIButton! = nil
    var bottomView : UIView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [timelineViewController,addressBookViewController,meViewController];
        // Do any additional setup after loading the view.
        self.tabBar.isHidden = true
        self.addBottomView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBottomView() {
        let heigth = 49 + kXbottom()
        let view = UIView.init(frame: CGRect(x: 0, y: kScreenHeight - heigth, width: kScreenWidth, height: heigth))
        view.backgroundColor = UIColor.white
        timelineViewController.view.addSubview(view)
        self.bottomView = view
        
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.colorWithHexString("#c7c8c9").cgColor
        lineLayer.frame = CGRect(x: 0, y: 0, width: view.width, height: kLinePixelWide)
        view.layer.addSublayer(lineLayer)
        
        let titleArr = ["动态","互关","我"]
        let imageArr = ["hy_homePage","hy_search","hy_my"]
        let btnWidth = kScreenWidth/3
        for index in 0...2 {
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.frame = CGRect(x: (CGFloat(index) * btnWidth), y: 0, width: btnWidth, height: 49)
            view.addSubview(btn)
            btn.setImage(UIImage.init(named: imageArr[index]), for: UIControlState.normal)
            btn.setImage(UIImage.init(named: imageArr[index] + "_select"), for: UIControlState.selected)
            btn.setTitle(titleArr[index], for: UIControlState.normal)
            btn.setTitleColor(UIColor.grayThree(), for: UIControlState.normal)
            btn.setTitleColor(UIColor.grayTwo(), for: UIControlState.selected)
            btn.addTarget(self, action: #selector(bottomBtnClick(_:)), for: UIControlEvents.touchUpInside)
            btn.tag = index + 100
            btn.titleLabel?.textAlignment = NSTextAlignment.center
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            btn.adjustImageRect(CGRect(x:(btnWidth - 25)/2, y: 4, width: 25, height: 25))
            btn.adjustTitleRect(CGRect(x: 0, y: 31, width: btnWidth, height: 18))
            if index == 0 {
                selectBtn = btn
                btn.isSelected = true
            }
        }
    }

    @objc func bottomBtnClick(_ btn:UIButton){
        self.selectWithIndex(btn.tag - 100)
    }
    
    func selectWithIndex(_ index : Int) {
        self.selectedIndex = index
        if index == 0 {
            timelineViewController.view.addSubview(self.bottomView)
        } else if index == 1 {
            addressBookViewController.view.addSubview(self.bottomView)
        } else {
            meViewController.view.addSubview(self.bottomView)
        }
        let btn : UIButton = self.bottomView.viewWithTag(index + 100) as! UIButton
        self.selectBtn.isSelected = false
        btn.isSelected = true
        self.selectBtn = btn
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
