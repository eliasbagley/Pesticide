//
//  Preferences.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

class Preferences {
    class func save(key: String, object: AnyObject?) {
        NSUserDefaults.standardUserDefaults().setObject(object, forKey:key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    class func load(key: String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().valueForKey(key)
    }

    class func isSet(key: String) -> Bool {
        let object: AnyObject? = Preferences.load(key)
        return object != nil ? true : false
    }
}
