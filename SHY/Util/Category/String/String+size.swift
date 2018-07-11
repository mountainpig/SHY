//
//  UIVIew+Positioning.swift
//  SHY
//
//  Created by 黄敬 on 2018/5/29.
//  Copyright © 2018年 hj. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func widthWithFont(_ font:UIFont) -> CGFloat{
        return self.boundingRect(with: CGSize(width:8000, height: 8000), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil).width
    }
    
    func height(font:UIFont,width:CGFloat) -> CGFloat{
        return self.boundingRect(with: CGSize(width:width, height: 8000), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil).height
    }
}
