//
//  CacheManager.swift
//  SHY
//
//  Created by 黄敬 on 2018/6/15.
//  Copyright © 2018年 hj. All rights reserved.
//

import UIKit
import YYCache

class CacheManager: NSObject {

    let cache = YYCache.init(name: "hy")!
    
    static let instance: CacheManager = CacheManager()
    class func sharedInstance() -> CacheManager
    {
        return instance
    }
    
    func save(object:Any,key:String)  {
        /*
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent(path)
        NSKeyedArchiver.archiveRootObject(object, toFile: accountPath)
        */
        self.cache.setObject(object as? NSCoding, forKey: key)
        
    }
    
    func getCache(key:String) -> Any? {
        /*
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent(path)
        return NSKeyedUnarchiver.unarchiveObject(withFile:accountPath)
 */
        return self.cache.object(forKey:key)
    }
}
