//
//  BaseObject.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/15.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit

@objcMembers class BaseObject: NSObject,NSCoding {
    
    func getPropertyNames() -> Array<String>{
        
        var outCount:UInt32
        
        outCount = 0

        let propers:UnsafeMutablePointer<objc_property_t>! =  class_copyPropertyList(self.classForCoder, &outCount)

        let count:Int = Int(outCount);
        
        var array = [String]()
        if count > 0 {
            for i in 0...(count-1) {
                
                let aPro: objc_property_t = propers[i]
                
                let proName:String! = String(utf8String: property_getName(aPro));
                
                array.append(proName)
            }
        }
        return array
        
    }
    
    
    func encode(with aCoder: NSCoder) {
     
        for key in self.getPropertyNames() {
            let value = self.encodeValue(forKey: key)
            if value  != nil {
                aCoder.encode(value, forKey: key)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        for key in self.getPropertyNames() {
            let value = aDecoder.decodeObject(forKey: key)
            self.decodeValue(value, forKey: key)
        }
    }
    
    func encodeValue(forKey key: String) -> Any?
    {
        return self.value(forKey:key)
    }

    func decodeValue(_ value: Any?, forKey key: String) {
        self.setValue(value, forKey: key)
    }
    
    override init() {
        super.init()
    }

}
