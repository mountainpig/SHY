//
//  FansListViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/7/2.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class FansListViewController: BasePullLoadingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "粉丝"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - NET
    override func netRequestIsPullDown(_ isPullDown: Bool) {
        AddressBookViewModel.getUserListData { (array) in
            if isPullDown {
                self.dataSuorceArray = array
                self.finishPulldownloading()
            } else {
                self.dataSuorceArray.appendArray(array)
                self.finishPulluploading()
            }
            self.table.reloadData()
        }
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
        let userModel = self.dataSuorceArray[indexPath.row] as! UserModel;
        let avatar = cell?.contentView.viewForTag(tag: 111, initView: { () -> UIView in
            let imageView = UIImageView.init(frame: CGRect(x: 14, y: 14, width: 40, height: 40))
            imageView.layer.cornerRadius = 20
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }) as! UIImageView
        avatar.sd_setImage(with: URL.init(string: userModel.avatar), completed: nil)
        
        let nameLabel = cell?.contentView.viewForTag(tag: 112, initView: { () -> UIView in
            let label = UILabel.init(frame: CGRect(x: avatar.right + 14, y: 0, width: self.view.width - 82, height: 68))
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.black
            return label
        }) as! UILabel
        nameLabel.text = userModel.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let userModel : UserModel = self.dataSuorceArray[indexPath.row] as! UserModel;
        self.jumpProfileWithUserId(userModel.userId)
    }

}
