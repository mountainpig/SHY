//
//  PinYinManager.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/25.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

class PinYinManager: NSObject {
    
    var listDict : NSDictionary! = nil
    
    static let instance: PinYinManager = PinYinManager()
    class func sharedInstance() -> PinYinManager
    {
        if instance.listDict == nil {
            let path = Bundle.main.path(forResource: "pinyin", ofType: "plist")
            instance.listDict = NSDictionary.init(contentsOfFile: path!)
        }
        return instance
    }
    
    class func pinYinFor(_ str : String) -> String {
        var result = ""
        for scalar in str.unicodeScalars{
            let unicode = String(format: "%0X", scalar.value)
            if unicode.count == 4 {
                let pinYin = PinYinManager.sharedInstance().listDict[unicode] as? String
                if pinYin == nil {
                    result += String(scalar)
                } else {
                    result += pinYin!.components(separatedBy: ",").first!
                }
            } else {
                result += String(scalar)
            }
        }
        /*
        let tempStr = NSString.init(string: str)
        for index in 0...tempStr.length - 1 {
           let char = tempStr.character(at: index)
            let pinYin = (self.listDict[NSString.init(format: "%x", char).uppercased] ?? tempStr.substring(with: NSRange.init(location: index, length: 1))) as! String
            result += pinYin.components(separatedBy: ",").first!
        }
 */
        return result
    }
}
