Pesticide
================

Pesticide is a  debugging framework for iOS which allows developers to use build in and custom debug controls at runtime. Pesticide was inspired by the [Debug Drawer](https://github.com/JakeWharton/u2020) for Android.

## Features
- [x] App level HTTP proxy configuration

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1

## Communication

Importing target with Git submodule

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

_Due to the current lack of [proper infrastructure](http://cocoapods.org) for Swift dependeny management, using Pesticde in your project requires the following steps:_

1. Add pesticide as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/eliasbagley/Pesticide.git`
2. Open the `debug-drawer` folder, and drag `debugdrawer.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of pesticide.xcodeproj matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add debug-drawer

---

## Usage

### Setup Pesticide

In your app delegate, simply call
```swift
Pesticide.setWindow(myWindow)
```
to setup Pesticide

### Using Pesticide

You can log to the pesticide live console using
```swift
Pesticide.log("some message")
```

You can add custom controls to the debug view controller using any of:

```swift
Pesticide.addSwitch(intialValue: Bool, name: String, block: Bool -> ())
Pesticide.addButton(name: String, block: () -> ())
Pesticide.addSlider(initialValue: Float, name: String, block: Float -> ())
Pesticide.addDropdown(initialValue: String, name: String, options: Dictionary<String,AnyObject>, block: (option: AnyObject) -> ())
Pesticide.addLabel(name: String, label: String)
Pesticide.addTextInput(name: String, block: (String) -> ())
```

The blocks are callbacks used when the value of the control is changed, allowing you to add custom functionality or run code ad hoc

```swift
Pesticide.addProxy(block: (NSURLSessionConfiguration?) -> ())
```
addProxy takes a closure that takes an NSURLSessionConfiguration? object allowing you to plug into whatever networking framework your project uses.
the NSURLSessionConfiguration will be configured based on a host and port. The syntax for the proxy textfield is "host:port"
e.g.
111.11.11.1:8888

You can also add more customized functionality using
```swift
Pesticide.addCommand(commandName: String, block: Array<String> -> ())
```
the block takes an array of words used in the command following the commandName. e.g.
```swift
Pesticide.addCommand("stab", block: { (components: Array<String>) in
                if components.count < 1 {
                    return;
                }
                if let times = components[0].toInt() {
                    for count in 0..<times {
                        Pesticide.log("die, die, die")
                    }
                }
            })
```
then, in the textfield, you can run:
```
stab 2
```
to get the output:

die, die, die
die, die, die

in the live view of the pesticide log

## Contributors

- [Elias Bagley](http://github.com/eliasbagley)
- [Abraham Hunt](http://github.com/abrahamhunt)
- [Daniel Gubler](http://github.com/apollinis)

## License

Pesticide is released under the MIT license. See LICENSE for details
