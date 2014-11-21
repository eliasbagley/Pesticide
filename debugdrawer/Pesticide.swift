//
//  Pesticide.swift
//  debugdrawer
//
//  Created by Daniel Gubler on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

public class Pesticide {
    
    var commands = Dictionary<String, (Array<String> -> Void)>()

    public func log(message: String) {
        print(message)
    }
    
    public func addCommand(commandName: String, block: Array<String> -> Void) {
        self.commands[commandName] = block
    }
    
    public func runFullCommand(command: String) {
        var components = command.componentsSeparatedByString(" ")
        let name = components.removeAtIndex(0)
        let block = self.commands[name]
        block?(components)
    }
}