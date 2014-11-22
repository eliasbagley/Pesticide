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
        static var window = UIWindow()
        static var isSetup = false
        static var viewInspector: ViewInspector?
    }

    public class func log(message: String) {
        logInfo(message)
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
    
    public class func addSwitch(intialValue: Bool, name: String, block: Bool -> ()) {
        CV.debugVC.addRowControl(SwitchControl(intialValue: intialValue, name: name, block: block))
    }
    
    public class func addButton(name: String, block: () -> ()) {
        CV.debugVC.addRowControl(ButtonControl(name: name, block: block))
    }
    
    public class func addSlider(intialValue: Float, name: String, block: Float -> ()) {
        CV.debugVC.addRowControl(SliderControl(intialValue: intialValue, name: name, block: block))
    }
    
    public class func addDropdown(initialValue: String, name: String, options: Dictionary<String,AnyObject>, block: (option: AnyObject) -> ()) {
        CV.debugVC.addRowControl(DropDownControl(initialValue: initialValue, name: name, options:options, block: block))
    }
    
    public class func addLabel(name: String, label: String) {
        CV.debugVC.addRowControl(LabelControl(name: name, label: label))
    }
    
    public class func addTextInput(name: String, block: (String) -> ()) {
        CV.debugVC.addRowControl(TextInputControl(name: name, block: block))
    }

    public class func addHeader(name: String) {
        CV.debugVC.addRowControl(LabelControl(name: name, label: ""))
    }
    
    public class func addProxy(block: (NSURLSessionConfiguration?) -> ()) {
        Pesticide.addTextInput("proxy", block: { (hostAndPort: String) in
            let config = Proxy.createSessionConfiguration(hostAndPort)
            block(config)
        })
    }
    
    public class func toggle() {
        var topVC :UIViewController = topViewController(CV.window.rootViewController!)
        if (topVC.isKindOfClass(DebugTableController)) {
//            CV.viewInspector?.done()
//            CV.viewInspector?.root.removeFromSuperview()

            topVC.dismissViewControllerAnimated(true, completion: nil)
        } else {
            topVC.presentViewController(CV.debugVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    
// MARK: setter functions
    
    public class func setWindow(window :UIWindow) {
        if (!CV.isSetup) {
            Pesticide.setup()
        }
        CV.window = window
    }
    
    
    
    
    
// MARK: private functions
    
    private class func setup() {
        Pesticide.startLogging()

        // Build information
        Pesticide.addHeader("Build Information")
        Pesticide.addLabel("date:", label: BuildUtils.getDateString())
        Pesticide.addLabel("version:", label: BuildUtils.getVersionString())
        Pesticide.addLabel("build:", label: BuildUtils.getBuildNumberString())
        Pesticide.addLabel("hash:", label: BuildUtils.getGitHash())

        // Device information
        Pesticide.addHeader("Device Information")
        Pesticide.addLabel("device:", label: DeviceUtils.getDeviceVersionString())
        Pesticide.addLabel("resolution:", label: DeviceUtils.getResolutionString())

        // User interface
        Pesticide.addHeader("User Interface")
        Pesticide.addButton("View Hierarchy", block: { () -> () in
            if let root = CV.window.rootViewController?.view {
                CV.viewInspector = ViewInspector(rootView: root)
//                CV.window.addSubview(root)
                self.toggle()
            }
        })

        // Network
        Pesticide.addHeader("Network")
        
        CV.isSetup = true
    }
    
    private class func topViewController(rootController :UIViewController)->UIViewController {
        if (rootController.presentedViewController != nil) {
            return topViewController(rootController.presentedViewController!)
        } else {
            return rootController;
        }
    }
    
    private class func startLogging () {
        DDLog.logLevel = .Verbose
        DDLog.addLogger(DDTTYLogger.sharedInstance())
        DDLog.addLogger(DDASLLogger.sharedInstance())
        let fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.addLogger(fileLogger)
    }
}