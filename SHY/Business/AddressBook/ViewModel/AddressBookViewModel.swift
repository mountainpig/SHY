//
//  AddressBookViewModel.swift
//  SHY
//
//  Created by 黄敬 on 2018/7/2.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class AddressBookViewModel: NSObject {
    class func getUserListData(completiom:(_ array:Array<UserModel>) ->()) {
        let path : String! = Bundle.main.path(forResource: "eachAttention_json", ofType: "txt")
        let content = try! String.init(contentsOf: URL.init(fileURLWithPath: path), encoding: String.Encoding.utf8)
        completiom(self.userModelFromRequestDict(content.jsonDictionaryValue()))
    }
    
    class func userModelFromRequestDict(_ dic: Dictionary<String, Any>) -> Array<UserModel>{
        
        var dataDic:Dictionary = dic["data"] as! Dictionary<String, Any>
        let userArr = dataDic["userList"] as! Array<Dictionary<String, Any>>
        var resultArray : Array<UserModel> = [];
        for info in userArr {
            let model = UserModel()
            model.avatar = info["avatar"] as! String
            model.name = info["userName"] as! String
            resultArray.append(model)
        }
        return resultArray
    }
}
