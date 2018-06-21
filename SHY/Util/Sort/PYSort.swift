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
    class func sortWithArray(_ array : Array<String>) -> Array<Array<SortModel>> {
        if array.count == 0 {
            return []
        }
        let collation : UILocalizedIndexedCollation! = UILocalizedIndexedCollation.current()
        
        var listArray : Array<Array<SortModel>> = []
        for _ in 0...collation.sectionTitles.count{
            let subArray : Array<SortModel> = []
            listArray.append(subArray)
        }
        
        for str in array {
            let model = SortModel.init()
            model.name = str
            model.index = collation.section(for: model, collationStringSelector: #selector(getter: model.name))
            model.sign = collation.sectionTitles[model.index]
            listArray[model.index].append(model);
            print("")
        }
        
        for (index,subArr) in listArray.enumerated() {
            listArray[index] = subArr.sorted { (obj1 : SortModel, obj2 : SortModel) -> Bool in
                return obj1.name.localizedCompare(obj2.name) == ComparisonResult.orderedAscending
            }
        }
        
        return listArray
    }
}
