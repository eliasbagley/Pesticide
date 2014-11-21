//
//  DebugTableController.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

class SectionInfo: NSObject {
    var rowObjects = [AnyObject]()
}

class DebugTableController: UITableViewController {
    
    var sectionObjects = [SectionInfo]()
    let consoleView = UITextView(frame: CGRectMake(0, 0, 320, 200));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.consoleView.editable = false
        self.consoleView.backgroundColor = UIColor.darkGrayColor()
        self.consoleView.textColor = UIColor.whiteColor()
        self.tableView .registerNib(UINib(nibName: CommandCellIdentifier, bundle: nil), forCellReuseIdentifier: CommandCellIdentifier)
        var info = SectionInfo()
        info.rowObjects.append(["logText":"cool stuff is cool"])
        self.sectionObjects.append(info)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(CommandCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, indexPath: indexPath)
        // Configure the cell...

        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 
//    }
    // MARK: - Configure Cell
    
    func configureCell(cell:UITableViewCell, indexPath : NSIndexPath) {
        
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

}
