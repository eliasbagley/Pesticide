//
//  DeviceUtils.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

class DeviceUtils {
    class func getDeviceVersionString() -> String {
        let version = UIDevice.currentDevice().systemVersion
        let model = UIDevice.currentDevice().model

        return "\(model) \(version)"
    }

    class func getResolutionString() -> String {
        let screenSize = UIScreen.mainScreen().bounds
        let scale = UIScreen.mainScreen().scale
        let width = Int(screenSize.width*scale)
        let height = Int(screenSize.height*scale)

        return "\(width)x\(height)"
    }
}
