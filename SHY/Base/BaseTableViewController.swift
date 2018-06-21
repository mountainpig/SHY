//
//  ViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ObserveTableView: UITableView {
    override dynamic var contentOffset: CGPoint {
        get {
            return super.contentOffset
        }
        set {
            super.contentOffset = newValue
        }
    }
}

class BaseTableViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var table:UITableView! = nil
    var dataSuorceArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table = ObserveTableView(frame:CGRect(x: 0, y: self.customNavigationView.bottom, width: kScreenWidth, height: self.view.height - self.customNavigationView.bottom), style:UITableViewStyle.plain)
        table.delegate = self;
        table.dataSource = self;
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never;
        table.estimatedRowHeight = 0;
        table.estimatedSectionHeaderHeight = 0;
        table.estimatedSectionFooterHeight = 0;
        self.view.addSubview(table)
        table.tableFooterView = UIView()
    }
    
    // MARK: - tableView delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSuorceArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell! = UITableViewCell()
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

