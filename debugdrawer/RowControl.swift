//
//  RowControl.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

enum ControlType {
    case Switch
    case Slider
    case Button
    case DropDown
    case Label
    case TextInput
}

class RowControl: NSObject {
    
    var name : String
    var type : ControlType
    
    init (name : String, type : ControlType) {
        self.name = name
        self.type = type
        super.init()
    }
}

class SwitchControl : RowControl {
    
    var block : Bool -> ()
    
    init (name : String, block: Bool -> ()) {
        self.block = block
        super.init(name: name, type: .Switch)
    }
}

class SliderControl : RowControl {
    
    var block : CGFloat -> ()
    
    init (name : String, block: CGFloat -> ()) {
        self.block = block
        super.init(name: name, type: .Slider)
    }
}

class ButtonControl : RowControl {
    
    var block : () -> ()
    
    init (name : String, block: () -> ()) {
        self.block = block
        super.init(name: name, type: .Button)
    }
}

class DropDownControl : RowControl {
    
    var options : Array<AnyObject>
    var block : (option: AnyObject, index: Int) -> ()
    
    init (name : String, options: Array<AnyObject>, block : (option: AnyObject, index: Int) -> ()) {
        self.block = block
        self.options = options
        super.init(name: name, type: .DropDown)
    }
}

class LabelControl : RowControl {
    
    init (name : String) {
        super.init(name: name, type: .Label)
    }
    
}

class TextInputControl : RowControl {
    
    var block : (input: String) -> ()
    
    init (name : String, block: (String) -> ()) {
        self.block = block
        super.init(name: name, type: .TextInput)
    }
}

