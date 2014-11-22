//
//  Proxy.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation
import Alamofire

let host = "144.38.22.117"
let port = 8888

class Proxy {
    var manager: Manager?

    class func createSessionConfiguration(host: String, port: Int) -> NSURLSessionConfiguration  {
        let dict = [
            kCFNetworkProxiesHTTPEnable as NSString : true,
            kCFStreamPropertyHTTPProxyPort : port,
            kCFStreamPropertyHTTPProxyHost : host as NSString

        ]

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.connectionProxyDictionary = dict


        return sessionConfiguration
    }


    init() {
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let configuration = Proxy.createSessionConfiguration()
        manager =  Alamofire.Manager(configuration: configuration)

        manager!.request(Router.ROOT).response { (request, response, data, error) in
            println(request)
            println(response)
            println(data)
            println(error)
        }
    }
}

enum Router: URLRequestConvertible {
//    static let baseURLString = "http://httpbin.org"
    static let baseURLString = "http://Eliass-MacBook-Pro.local:8000"

    case ROOT

    var method: Alamofire.Method {
        switch self {
        case .ROOT:
            return .GET
        }
    }

    // MARK: URLRequestConvertible

    var URLRequest:NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?) = {
            switch (self) {
            case .ROOT:
                return ("/", nil)
            }
        }()

        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue;

        return URLRequest
    }
}
