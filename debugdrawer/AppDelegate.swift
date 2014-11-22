//
//  AppDelegate.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var manager: Manager?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
            let threeFingerTap = UITapGestureRecognizer(target: self, action: Selector("threeFingerTap"))
            threeFingerTap.numberOfTouchesRequired = 3
            self.window?.addGestureRecognizer(threeFingerTap)
            
            Pesticide.setWindow(self.window!)


            Pesticide.addProxy({ (config: NSURLSessionConfiguration) in
                self.manager =  Alamofire.Manager(configuration: config)
            })
            
            Pesticide.addHeader("Custom Controls")
        #endif
        
        var rootView = SampleViewController()
        
        if let window = self.window {
            window.rootViewController = rootView
        }
        
        return true
    }

    func makeNetworkRequest() {
        self.manager?.request(Router.ROOT).response { (request, response, data, error) in
            println(request)
            println(response)
            println(data)
            println(error)
            Pesticide.log("Network call success")
        }
    }
    
#if DEBUG
    func threeFingerTap() {
        Pesticide.toggle()
    }
#endif

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

enum Router: URLRequestConvertible {
    static let baseURLString = "http://httpbin.org"

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
        URLRequest.HTTPMethod = method.rawValue
        
        return URLRequest
    }
}

