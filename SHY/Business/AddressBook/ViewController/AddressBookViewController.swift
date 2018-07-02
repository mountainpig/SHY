//
//  AddressBookViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/30.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import SDWebImage

class AddressBookViewController: BaseTableViewController{
    var listArray : Array<Array<SortModel>> = []

    override func viewDidLoad() {
        self.hiddenBackBtn = true
        super.viewDidLoad()
        self.title = "互关"
        self.table.height -= (49 + kXbottom())
        AddressBookViewModel.getUserListData { (userArr) in
            listArray = PYSort.sortWithUserArray(userArr)
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier";
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let model :SortModel = listArray[indexPath.section][indexPath.row];
        let avatar = cell?.contentView.viewForTag(tag: 111, initView: { () -> UIView in
            let imageView = UIImageView.init(frame: CGRect(x: 14, y: 14, width: 40, height: 40))
            imageView.layer.cornerRadius = 20
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }) as! UIImageView
        let userModel = model.model as! UserModel
        avatar.sd_setImage(with: URL.init(string: userModel.avatar), completed: nil)
        
        let nameLabel = cell?.contentView.viewForTag(tag: 112, initView: { () -> UIView in
            let label = UILabel.init(frame: CGRect(x: avatar.right + 14, y: 0, width: self.view.width - 82, height: 68))
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.black
            return label
        }) as! UILabel
        nameLabel.text = model.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model :SortModel = listArray[indexPath.section][indexPath.row];
        let userModel = model.model as! UserModel
        self.jumpProfileWithUserId(userModel.userId)
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
