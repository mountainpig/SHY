//
//  ProfileAlphaNavigationView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileAlphaNavigationView: UIView {

    let animationView = ProfileAnimationRefreshView.init(frame: CGRect.width(22))
    weak var viewController : UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.animationView.right = self.width - 14
        self.animationView.top = (self.height - self.animationView.height)/2
        self.addSubview(self.animationView)

        let backBtn = UIButton.init(frame: CGRect.width(44))
        backBtn.setImage(UIImage.init(named: "hy_back"), for: UIControlState.normal)
        backBtn.adjustImageRect(CGRect(x: 9, y: 13.5, width: 17, height: 17))
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        self.addSubview(backBtn)
    }

    @objc func backClick(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }

    func scrollHeight(_ height: CGFloat) {

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
