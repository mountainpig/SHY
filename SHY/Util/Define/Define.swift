//
//  Define.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/29.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation
import UIKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kScreenRect = UIScreen.main.bounds
let kLinePixelWide = 1/UIScreen.main.scale

func kXtop() -> CGFloat {
    if (kScreenHeight == 812) {
        return 24
    }
    return 0
}

func kXbottom() -> CGFloat {
    if (kScreenHeight == 812) {
        return 34
    }
    return 0
}
