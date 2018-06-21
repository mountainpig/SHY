//
//  UIVIew+Positioning.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/29.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func adjustImageRect(_ rect :CGRect) {
        self.imageEdgeInsets = UIEdgeInsetsMake(rect.origin.y, rect.origin.x, self.height - rect.origin.y - rect.size.height,self.width - rect.origin.x - rect.size.width)
    }
    
    func adjustTitleRect(_ rect :CGRect) {
        var imageWith : CGFloat = 0;
        let view = self.imageView
        if view != nil {
            imageWith += view!.width
        }
        self.titleEdgeInsets = UIEdgeInsetsMake(rect.origin.y, rect.origin.x - imageWith, self.height - rect.origin.y - rect.size.height,self.width - rect.origin.x - rect.size.width)
        print(self.titleEdgeInsets)
    }
    
}
