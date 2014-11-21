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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView .registerNib(UINib(nibName: ConsoleCellIdentifier, bundle: nil), forCellReuseIdentifier: ConsoleCellIdentifier)
        var info = SectionInfo()
        info.rowObjects.append(["logText":"cool stuff is cool"])
        self.sectionObjects.append(info)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(ConsoleCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, indexPath: indexPath)
        // Configure the cell...

        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 
//    }
    // MARK: - Configure Cell
    
    func configureCell(cell:UITableViewCell, indexPath : NSIndexPath) {
        if let consoleCell = cell as? ConsoleCell {
            let info = self.sectionObjects[indexPath.section]
            if let rowDictionary = info.rowObjects[indexPath.row] as? Dictionary <String,String> {
                consoleCell.consoleView.text = rowDictionary["logText"]
            }
        }
    }

}
