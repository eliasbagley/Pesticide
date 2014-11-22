//
//  Proxy.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

class Proxy {
    // creates a NSURLSessionConfiguration object from a string in the form host:port
    class func createSessionConfiguration(hostAndPort: String) -> NSURLSessionConfiguration {
        let hostAndPortArr = hostAndPort.componentsSeparatedByString(":")

        if hostAndPortArr.count != 2 {
            return NSURLSessionConfiguration.defaultSessionConfiguration()
        }

        let host = hostAndPortArr[0]
        let port = hostAndPortArr[1].toInt()

        if port != nil {
            return createSessionConfigurationFromHost(host, port: port!)
        }

        return NSURLSessionConfiguration.defaultSessionConfiguration()
    }

    // creates a NSURLSessionConfiguration object from a host and port
    class func createSessionConfigurationFromHost(host: String, port: Int) -> NSURLSessionConfiguration  {
        let dict = [
            kCFNetworkProxiesHTTPEnable as NSString : true,
            kCFStreamPropertyHTTPProxyPort : port,
            kCFStreamPropertyHTTPProxyHost : host as NSString

        ]

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.connectionProxyDictionary = dict


        return sessionConfiguration
    }
}
