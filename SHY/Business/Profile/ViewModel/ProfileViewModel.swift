//
//  ProfileViewModel.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/27.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class ProfileViewModel: NSObject {

    
    class func getUserData(completiom:(_ userModel:UserModel) ->()) {
        let path : String! = Bundle.main.path(forResource: "profileUserInfo_json", ofType: "txt")
        let content = try! String.init(contentsOf: URL.init(fileURLWithPath: path), encoding: String.Encoding.utf8)
        completiom(self.userModelFromRequestDict(content.jsonDictionaryValue()))
    }
    
    class func userModelFromRequestDict(_ dic: Dictionary<String, Any>) -> UserModel{
        let model = UserModel()
        var dataDic:Dictionary = dic["data"] as! Dictionary<String, Any>
        model.avatar = dataDic["avatar"] as! String
        model.name = dataDic["userName"] as! String
        model.desc = dataDic["description"] as! String
        model.fansCount = dataDic["followerCount"] as! Int
        model.attentionCount = dataDic["followCount"] as! Int
        model.profileBgs = dataDic["profileBgs"] as! String
        return model
    }
    
}
