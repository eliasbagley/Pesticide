//
//  Pesticide.swift
//  debugdrawer
//
//  Created by Daniel Gubler on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

public enum PesticideControlType {
    case Button
    case Switch
    case Slider
    case Dropdown
    case Label
}

public class Pesticide {
    
    private struct CVWrapper {
        static let debugVC = DebugTableController()
        static var commands = Dictionary<String, (Array<String> -> Void)>()
    }

    public class func log(message: String) {
        print(message)
    }
    
    public class func addCommand(commandName: String, block: Array<String> -> Void) {
        CVWrapper.commands[commandName] = block
    }
    
    public class func runFullCommand(command: String) {
        var components = command.componentsSeparatedByString(" ")
        let name = components.removeAtIndex(0)
        let block = CVWrapper.commands[name]
        block?(components)
    }
    
    public class func addControl(name: String, type: PesticideControlType) {
    
    }
    
    public class func debugViewController()->UIViewController {
        return CVWrapper.debugVC
    }
}