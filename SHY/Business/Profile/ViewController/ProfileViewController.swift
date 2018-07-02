//
//  ProfileViewController.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileViewController: FeedViewController,ProfileHeadViewProtocol {

    let maxScrollHeight = kScreenWidth/6;
    var headView : ProfileHeadView! = nil
    var alphaNavigationView = ProfileAlphaNavigationView.init(frame: CGRect(x: 0, y: 20 + kXtop(), width: kScreenWidth, height: 44))
    var userModel : UserModel! = nil
    
    override func viewDidLoad() {
        self.hiddenPullDownRefresh = true
        super.viewDidLoad()
        self.customNavigationView.isHidden = true
        self.view.insertSubview(alphaNavigationView, belowSubview: self.customNavigationView)
        self.alphaNavigationView.viewController = self
        
        self.table.frame = self.view.bounds
        ProfileViewModel.getUserData { (user) in
            self.userModel = user
            headView = ProfileHeadView.init(frame: CGRect.zero)
            headView.delegate = self
            headView.loadWithUser(user)
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
            if scrollView.contentOffset.y < -maxScrollHeight {
                scrollView.contentOffset.y = -maxScrollHeight
            }
            if self.headView != nil {
                self.headView.scrollHeight(-scrollView.contentOffset.y)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y <= -maxScrollHeight) {
            self.alphaNavigationView.animationView.beginAnimation()
            self.netRequestIsPullDown(true)
        }
    }
    
    override func finishPulldownloading() {
        super.finishPulldownloading()
        self.alphaNavigationView.animationView.ednAnimation()
    }
        // MARK: - head delegate
    func headViewEvent(event: ProfileHeadViewEvent, sender: Any) {
        switch event {
        case .headClick:
            let model = ImageModel()
            model.smallUrlString = self.userModel.avatar
            model.bigUrlString = self.userModel.hd_avatar
            let imageView = sender as! UIImageView
            let view = ImagesHorizontalView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth + 20, height: kScreenHeight))
            view.hiddenTapImge = true
            self.view.addSubview(view)
            view.animationApear(array: [model],index : 0,imageViewArray : [imageView])
            break
        case .fansClick:
                self.jumpFansListWithUserId(self.userModel.userId)
            break
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
