//
//  PesticideLogger.swift
//  debugdrawer
//
//  Created by Abraham Hunt on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import UIKit

class PesticideLogger: DDAbstractLogger {
    
    var textView : UITextView?
    var dateFormatter : NSDateFormatter
    override init() {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        super.init()
    }
    
    override func logMessage(logMessage: DDLogMessage!) {
        if  self.textView != nil {
            if  logMessage != nil {
                var logString = self.formatMessage(logMessage)
                dispatch_async(dispatch_get_main_queue(),{
                    if var currentText = self.textView!.text {
                        currentText = currentText + logString
                        logString = currentText
                    }
                    self.textView!.text = logString + "\n"
                    self.textView?.scrollRangeToVisible(NSMakeRange(logString.utf16Count - 1, 1))
                });
            }
        }
        return
    }
    
    func formatMessage(logMessage : DDLogMessage) -> String {
        let message = logMessage.message
        let date = logMessage.timestamp
        let dateString = self.dateFormatter.stringFromDate(date)
        return "\(dateString)  \(message)"
    }
}