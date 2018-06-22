//
//  AddressBookViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/30.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class AddressBookViewController: BaseTableViewController{
    var listArray = PYSort.sortWithArray(["莹","小","网","王","社","可","开","huangjing","黄敬","洪流一滴泪","demon","不胖只是肉多","Annybaby","狐小仙"])

    override func viewDidLoad() {
        self.hiddenBackBtn = true
        super.viewDidLoad()
        self.title = "互关"
        self.table.height -= (49 + kXbottom())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray[section].count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier";
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let model :SortModel = listArray[indexPath.section][indexPath.row];
        cell!.textLabel?.text = model.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if listArray[section].count > 0 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
            view.backgroundColor = UIColor.colorWithHexString("#eeeeee")
            let label = UILabel.init(frame: CGRect(x: 14, y: 0, width: 50, height: 20))
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.grayThree()
            label.text = listArray[section].first?.sign
            view.addSubview(label)
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if listArray[section].count > 0 {
            return 20
        }
        return 0
    }

}
