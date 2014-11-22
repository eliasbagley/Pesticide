//
//  DebugTableController.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

class SectionInfo: NSObject {
    var rowObjects = Array<RowControl>()
}

class DebugTableController: UITableViewController {
    
    var sectionObjects = [SectionInfo()]
    let consoleView = UITextView(frame: CGRectMake(0, 0, 320, 200));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.consoleView.editable = false
        self.consoleView.backgroundColor = UIColor.darkGrayColor()
        self.consoleView.textColor = UIColor.whiteColor()
        let cellIds : Array<ControlType> = [.Switch,.Slider,.Button,.TextInput,.Label]
        for type in cellIds {
            self.tableView.registerNib(UINib(nibName: type.rawValue, bundle: nil), forCellReuseIdentifier:type.rawValue)
        }
        self.tableView .registerNib(UINib(nibName: CommandCellIdentifier, bundle: nil), forCellReuseIdentifier: CommandCellIdentifier)
        self.readCurrentLog()
        self.tableView.tableHeaderView = self.consoleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.sectionObjects.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let info = self.sectionObjects[section]
        return info.rowObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionInfo = self.sectionObjects[indexPath.section]
        let rowControl = sectionInfo.rowObjects[indexPath.row]
        var identifier = rowControl.type
        if  identifier == .DropDown {
            identifier = .TextInput
        }
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier.rawValue, forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    // MARK: - Configure Cell
    
    func configureCell(cell:UITableViewCell, indexPath : NSIndexPath) {
        let sectionInfo = self.sectionObjects[indexPath.section]
        let rowControl = sectionInfo.rowObjects[indexPath.row]
        let pesticideCell = cell as PesticideCell
        pesticideCell.setName(rowControl.name)
        switch rowControl.type {
        case .Switch:
            let switchCell = cell as SwitchCell
            switchCell.switchControl.addTarget(self, action: Selector("switchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        case .Slider:
            let sliderCell = cell as SliderCell
            sliderCell.slider.addTarget(self, action: Selector("sliderChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        case .Button:
            let buttonCell = cell as ButtonCell
            buttonCell.button.addTarget(self, action: Selector("buttonTapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        case .DropDown:
            let dropDown = cell as TextFieldCell
            dropDown.textField.addTarget(self, action: Selector("editingEnded:"), forControlEvents: UIControlEvents.EditingDidEnd)
        case .TextInput:
            let textInput = cell as TextFieldCell
            textInput.textField.addTarget(self, action: Selector("editingEnded:"), forControlEvents: UIControlEvents.EditingDidEnd)
        case .Label:
            let bob = "Bob"
        }
    }
    
    func readCurrentLog() {
        logInfo("Read log")
        let fileLogger = DDFileLogger()
        let logFileInfo = fileLogger.currentLogFileInfo()
        if let logData = NSData(contentsOfFile: logFileInfo.filePath) {
            let logString = NSString(data: logData, encoding: NSUTF8StringEncoding)
            self.consoleView.text = logString!
        }
        let consoleLogger = PesticideLogger();
        consoleLogger.textView = self.consoleView
        DDLog.addLogger(consoleLogger)
        logInfo("added log watcher")
    }

    func addRowControl(rowControl : RowControl) {
        self.sectionObjects[0].rowObjects.append(rowControl)
        self.tableView.reloadData()
    }
    
    func switchChanged(sender: UISwitch) {
        if let indexPath = self.indexPathForCellSubview(sender) {
            let sectionInfo = self.sectionObjects[indexPath.section]
            if let control = sectionInfo.rowObjects[indexPath.row] as? SwitchControl {
                control.executeBlock(sender.on)
            }
        }
    }
    
    func sliderChanged(sender: UISlider) {
        if let indexPath = self.indexPathForCellSubview(sender) {
            let sectionInfo = self.sectionObjects[indexPath.section]
            if let control = sectionInfo.rowObjects[indexPath.row] as? SliderControl {
                control.executeBlock(sender.value)
            }
        }
    }
    
    func buttonTapped(sender: UIButton) {
        if let indexPath = self.indexPathForCellSubview(sender) {
            let sectionInfo = self.sectionObjects[indexPath.section]
            if let control = sectionInfo.rowObjects[indexPath.row] as? ButtonControl {
                control.executeBlock()
            }
        }
    }
    
    func editingEnded(sender: UITextField) {
        if let indexPath = self.indexPathForCellSubview(sender) {
            let sectionInfo = self.sectionObjects[indexPath.section]
            if let control = sectionInfo.rowObjects[indexPath.row] as? TextInputControl {
                control.executeBlock(sender.text)
            }
        }
    }
    
    func indexPathForCellSubview(subview: UIView) -> NSIndexPath? {
        let aPoint = self.tableView.convertPoint(CGPointZero, fromView: subview)
        return self.tableView.indexPathForRowAtPoint(aPoint)
    }
}
