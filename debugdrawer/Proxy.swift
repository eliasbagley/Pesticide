//
//  Proxy.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

class Proxy {
    class func createSessionConfiguration() -> NSURLSessionConfiguration  {
        let dict = [kCFProxyHostNameKey as String : "192.168.43.24",
            kCFProxyPortNumberKey : "8888",
            kCFProxyTypeKey : kCFProxyTypeHTTP
        ]

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.connectionProxyDictionary = dict;


        return sessionConfiguration
    }


    func test() {
        let session =  NSURLSession(configuration: Proxy.createSessionConfiguration())

    }

}