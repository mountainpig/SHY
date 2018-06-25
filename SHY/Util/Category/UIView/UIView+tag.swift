//
//  UIView+tag.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/22.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation

extension UIView {
    func viewForTag(tag : Int,initView:() ->UIView) -> UIView {
        if self.viewWithTag(tag) == nil {
            let view = initView()
            view.tag = tag
            self.addSubview(view)
        }
        return self.viewWithTag(tag)!
    }
}
