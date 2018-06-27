//
//  ProfileViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileViewController: FeedViewController {

    var headView : ProfileHeadView! = nil
    
    override func viewDidLoad() {
        self.hiddenPullDownRefresh = true
        super.viewDidLoad()
        self.customNavigationView.isHidden = true
        self.table.frame = self.view.bounds
        ProfileViewModel.getUserData { (userModel) in
            headView = ProfileHeadView.init(frame: CGRect.zero)
            headView.loadWithUser(userModel)
            self.table.tableHeaderView = headView
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            if scrollView.contentOffset.y < -kScreenWidth/6 {
                scrollView.contentOffset.y = -kScreenWidth/6
            }
            if self.headView != nil {
                self.headView.scrollHeight(-scrollView.contentOffset.y)
            }
        }
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
