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
    func jsonDictionaryValue() -> Dictionary<String, Any>{
        let data : Data = self.data(using: String.Encoding.utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
    }
 
}
