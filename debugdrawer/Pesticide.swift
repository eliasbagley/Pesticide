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
    
    private struct CV {
        static let debugVC = DebugTableController()
        static var commands = Dictionary<String, Array<String> -> ()>()
    }

    public class func log(message: String) {
        print(message)
    }
    
    public class func addCommand(commandName: String, block: Array<String> -> ()) {
        CV.commands[commandName] = block
    }
    
    class func runFullCommand(command: String) {
        var components = command.componentsSeparatedByString(" ")
        let name = components.removeAtIndex(0)
        let block = CV.commands[name]
        block?(components)
    }
    
    public class func addSwitch(name: String, block: Bool -> ()) {
        
    }
    
    public class func addButton(name: String, block: () -> ()) {
        
    }
    
    public class func addSlider(name: String, block: (CGFloat) -> ()) {
        
    }
    
    public class func addDropdown(name: String, options: Array<AnyObject>, block: (option: AnyObject, index: Int) -> ()) {
        
    }
    
    public class func addLabel(name: String, label: String) {
        
    }
    
    public class func debugViewController()->UIViewController {
        return CV.debugVC
    }
}