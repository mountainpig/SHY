//
//  FeedModel.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/28.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import YYText

enum FeedType : Int{
    case common = 1
    case image = 2
    case video = 3
}

class FeedCellLayout: BaseObject {
    var cellHeight : CGFloat = 0.0
    var imagesViewHeight : CGFloat = 0.0
    var imagesViewTop : CGFloat = 0.0
    var textHeight : CGFloat = 0.0
    var textTop : CGFloat = 0.0
    var textLayout : YYTextLayout! = nil
}

class FeedModel: BaseObject {
    var avatar = ""
    var name = ""
    var time = ""
    var feedType = 0
    var imageArray : Array<ImageModel>?
    var layout : FeedCellLayout!

}
