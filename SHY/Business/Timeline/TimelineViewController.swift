//
//  TimelineViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/5.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class TimelineViewController: FeedViewController {

    override func viewDidLoad() {
        self.hiddenBackBtn = true
        super.viewDidLoad()
        self.title = "动态"
        // Do any additional setup after loading the view.
        self.table.height -= (49 + kXbottom());
        
        let photoBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 51, height: 44))
        self.customNavigationView.addSubview(photoBtn)
        photoBtn.setImage(UIImage.init(named: "hy_timeline_camera"), for: UIControlState.normal)
        photoBtn.adjustImageRect(CGRect(x: 14, y: 10.5, width: 23, height: 23))
        photoBtn.addTarget(self, action: #selector(photoClick), for: UIControlEvents.touchUpInside)
    }
    
    @objc func photoClick() {
        self.jumpPhotoViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
