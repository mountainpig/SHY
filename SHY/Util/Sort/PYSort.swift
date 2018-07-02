//
//  Sort.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/30.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class SortModel: NSObject {
    @objc var name : String!
    var haspy : Bool = false
    var model : Any?
    var pyname : String?
    var sign : String? // ABCDEFGHIJKILMNOPORSTUVWXYZ#
    var index : Int! = 0
}

class PYSort: NSObject {
    class func sortWithUserArray(_ array : Array<UserModel>) -> Array<Array<SortModel>> {
        if array.count == 0 {
            return []
        }
        let collation : UILocalizedIndexedCollation! = UILocalizedIndexedCollation.current()
        
        var listArray : Array<Array<SortModel>> = []
        for _ in 0...collation.sectionTitles.count{
            let subArray : Array<SortModel> = []
            listArray.append(subArray)
        }
        
        for user in array {
            let model = SortModel.init()
            model.name = user.name
            model.index = collation.section(for: model, collationStringSelector: #selector(getter: model.name))
            model.sign = collation.sectionTitles[model.index]
            model.model = user
            listArray[model.index].append(model);
        }
        
        for (index,subArr) in listArray.enumerated() {
            listArray[index] = subArr.sorted { (obj1 : SortModel, obj2 : SortModel) -> Bool in
                return obj1.name.localizedCompare(obj2.name) == ComparisonResult.orderedAscending
            }
        }
        
        return listArray
    }
}
