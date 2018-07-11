//
//  ViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import YYText
import RealmSwift

class FeedViewController: BasePullLoadingViewController {

    let enventCenter : FeedEventCenter! = FeedEventCenter.init()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enventCenter.viewController = self
        let btn = UIButton.init()
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.addTarget(self, action: #selector(addressBookClick), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(btn)
//        self.dataSuorceArray = CacheManager.sharedInstance().getCache(key: "timeline") as! [Any]
    }
    
    @objc func addressBookClick(){
        self.navigationController?.pushViewController(AddressBookViewController(), animated: true)
    }
    
    // MARK: - tableView delegate


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier";
        var cell : FeedTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? FeedTableViewCell
        if cell == nil {
            cell = FeedTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let model :FeedModel = dataSuorceArray[indexPath.row] as! FeedModel;
        cell?.loadWithModel(feedModel: model, eventCenter: self.enventCenter);
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model :FeedModel = dataSuorceArray[indexPath.row] as! FeedModel;
        return model.layout.cellHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - NET
    override func netRequestIsPullDown(_ isPullDown: Bool) {
        //        let temp = UInt64(arc4random()%2)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            FeedListViewModel.getData(isPullDown: isPullDown, completiom: { (array) in
                if isPullDown {
                    self.dataSuorceArray = array
                    self.finishPulldownloading()
                } else {
                    self.dataSuorceArray.append(contentsOf: array)
                    self.finishPulluploading()
                }
//                CacheManager.sharedInstance().save(object: self.dataSuorceArray, key: "timeline")
                self.table.reloadData()
            })
//        }
    }

}

