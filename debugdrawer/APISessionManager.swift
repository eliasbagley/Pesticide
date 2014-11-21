//
//  APISessionManager.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

typealias APIFailureBlock = (task: NSURLSessionDataTask!, error:NSError!) -> Void
let APIURL = "http://ip.jsontest.com/"

class APISessionManager : AFHTTPSessionManager {

    convenience override init() {
        let URL = NSURL(string: APIURL)
        self.init(baseURL: URL)
        self.requestSerializer = AFHTTPRequestSerializer()
    }

    convenience override init(sessionConfiguration: NSURLSessionConfiguration) {
        let url = NSURL(string: APIURL)
        self.init(baseURL:url, sessionConfiguration: sessionConfiguration)
    }

    override init!(baseURL url: NSURL!) {
        super.init(baseURL: url)
        
        self.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
    }

    override init!(baseURL url: NSURL!, sessionConfiguration: NSURLSessionConfiguration!) {
        super.init(baseURL: url, sessionConfiguration: sessionConfiguration)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("Init(Coder:) has not been implemented")
    }

}

extension APISessionManager {
    func getTest(success: () -> Void, failure: APIFailureBlock) -> NSURLSessionDataTask {
        let path = ""

        return self.GET(path, parameters:nil, success: { (task, responseObject) -> Void in
            success()
        }, failure: failure)

    }
}
