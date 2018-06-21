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
        super.viewDidLoad()
        self.title = "动态"
        // Do any additional setup after loading the view.
        self.table.height -= (49 + kXbottom());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
