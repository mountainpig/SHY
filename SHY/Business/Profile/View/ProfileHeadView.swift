//
//  ProfileHeadView.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

enum ProfileHeadViewEvent {
    case headClick
}

protocol ProfileHeadViewProtocol : NSObjectProtocol{
    func headViewEvent(event : ProfileHeadViewEvent,sender : Any)
}

class ProfileHeadView: UIView {

    let corverImgeView = UIImageView()
    let headImgView = UIImageView()
    let nameLabel = UILabel()
    let attentionBtn = UIButton()
    let fansBtn = UIButton()
    let descLabel = UILabel()
    var userModel : UserModel! = nil
    weak var delegate : ProfileHeadViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = false
        
        self.corverImgeView.size = CGSize(width: kScreenWidth, height: kScreenWidth/3)
        self.corverImgeView.clipsToBounds = true
        self.corverImgeView.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(self.corverImgeView)
        
        self.headImgView.frame = CGRect(x: 14, y: self.corverImgeView.bottom - 46, width: 92, height: 92)
        self.addSubview(self.headImgView)
        self.headImgView.layer.cornerRadius = self.headImgView.width/2
        self.headImgView.clipsToBounds = true
        self.headImgView.addTap(target: self, action: #selector(headImgClick(_:)))
        
        self.nameLabel.frame = CGRect(x: 14, y: self.headImgView.bottom, width: 160, height: 40)
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
        self.userModel = user
        self.corverImgeView.sd_setImage(with: URL.init(string: user.profileBgs), completed: nil)
        self.headImgView.sd_setImage(with: URL.init(string: user.avatar), completed: nil)
        self.nameLabel.text = user.name
        self.attentionBtn.setTitle("关注 \(user.attentionCount)", for: UIControlState.normal)
        self.fansBtn.setTitle("关注 \(user.fansCount)", for: UIControlState.normal)
        self.descLabel.text = user.desc
    }
    
    func scrollHeight(_ height: CGFloat) {
        self.corverImgeView.top = -height
        self.corverImgeView.height = kScreenWidth/3 + height
    }
    
    @objc func headImgClick(_ sender:UITapGestureRecognizer)
    {
        self.delegate?.headViewEvent(event: ProfileHeadViewEvent.headClick, sender: sender.view as Any)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
