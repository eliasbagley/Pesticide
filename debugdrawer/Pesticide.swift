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
        CV.debugVC.addRowControl(SwitchControl(name: name, block: block))
    }
    
    public class func addButton(name: String, block: () -> ()) {
        CV.debugVC.addRowControl(ButtonControl(name: name, block: block))
    }
    
    public class func addSlider(name: String, block: Float -> ()) {
        CV.debugVC.addRowControl(SliderControl(name: name, block: block))
    }
    
    public class func addDropdown(name: String, options: Array<String>, block: (option: String) -> ()) {
        CV.debugVC.addRowControl(DropDownControl(name: name, options:options, block: block))
    }
    
    public class func addLabel(name: String, label: String) {
        CV.debugVC.addRowControl(LabelControl(name: name))
    }
    
    public class func addTextInput(name: String, block: (String) -> ()) {
        CV.debugVC.addRowControl(TextInputControl(name: name, block: block))
    }
    
    public class func debugViewController()->UIViewController {
        return CV.debugVC
    }
}