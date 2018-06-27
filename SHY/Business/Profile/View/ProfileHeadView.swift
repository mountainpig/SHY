//
//  ProfileHeadView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileHeadView: UIView {

    let corverImgeView = UIImageView()
    let headBtn = UIButton()
    let nameLabel = UILabel()
    let attentionBtn = UIButton()
    let fansBtn = UIButton()
    let descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.corverImgeView.size = CGSize(width: kScreenWidth, height: kScreenWidth/3)
        self.corverImgeView.clipsToBounds = true
        self.corverImgeView.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.corverImgeView)
        
        self.headBtn.frame = CGRect(x: 14, y: self.corverImgeView.bottom - 46, width: 92, height: 92)
        self.addSubview(self.headBtn)
        self.headBtn.layer.cornerRadius = self.headBtn.width/2
        self.headBtn.clipsToBounds = true
        
        self.nameLabel.frame = CGRect(x: 14, y: self.headBtn.bottom, width: 160, height: 40)
        self.nameLabel.textColor = UIColor.black
        self.nameLabel.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(self.nameLabel)
        
        self.attentionBtn.frame = CGRect(x: 14, y: self.nameLabel.bottom, width: 60, height: 40)
        self.attentionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.attentionBtn.setTitleColor(UIColor.grayTwo(), for: UIControlState.normal)
        self.addSubview(self.attentionBtn)
        
        self.fansBtn.frame = CGRect(x: self.attentionBtn.right, y: self.nameLabel.bottom, width: 60, height: 40)
        self.fansBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.fansBtn.setTitleColor(UIColor.grayTwo(), for: UIControlState.normal)
        self.addSubview(self.fansBtn)
        
        self.descLabel.frame = CGRect(x: 14, y: self.attentionBtn.bottom, width: kScreenWidth - 28, height: 20)
        self.descLabel.textColor = UIColor.grayTwo()
        self.descLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(self.descLabel)
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: self.descLabel.bottom)
    }
    
    func loadWithUser(_ user:UserModel){
        self.corverImgeView.sd_setImage(with: URL.init(string: user.profileBgs), completed: nil)
        self.headBtn.sd_setBackgroundImage(with: URL.init(string: user.avatar), for: UIControlState.normal, completed: nil)
        self.nameLabel.text = user.name
        self.attentionBtn.setTitle("关注 \(user.attentionCount)", for: UIControlState.normal)
        self.fansBtn.setTitle("关注 \(user.fansCount)", for: UIControlState.normal)
        self.descLabel.text = user.desc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
