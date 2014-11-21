// Created by Ullrich Schäfer on 16/08/14.
// Updated to Swift 1.1 and CocoaLumberjack beta4 by Stan Serebryakov on 24/10/14
// https://gist.github.com/cfr/7da8da56654288fad7aa

import Foundation

extension DDLog {
    
    private struct State {
        static var logLevel: DDLogLevel = .Error
        static var logAsync: Bool = true
    }
    
    class var logLevel: DDLogLevel {
        get { return State.logLevel }
        set { State.logLevel = newValue }
    }
    
    class var logAsync: Bool {
        get { return (self.logLevel != .Error) && State.logAsync }
        set { State.logAsync = newValue }
    }
    
    class func log(flag: DDLogFlag, message: @autoclosure () -> String,
        function: String = __FUNCTION__, file: String = __FILE__,  line: UInt = __LINE__) {
            if flag.rawValue & logLevel.rawValue != 0 {
                var logMsg = DDLogMessage(message: message(), level: logLevel, flag: flag, context: 0,
                    file: file, function: function, line: line,
                    tag: nil, options: DDLogMessageOptions(0), timestamp: nil)
                DDLog.log(logAsync, message: logMsg)
            }
    }
}

func logError(message: @autoclosure () -> String, function: String = __FUNCTION__,
    file: String = __FILE__, line: UInt = __LINE__) {
        DDLog.log(.Error, message: message, function: function, file: file, line: line)
}

func logWarn(message: @autoclosure () -> String, function: String = __FUNCTION__,
    file: String = __FILE__, line: UInt = __LINE__) {
        DDLog.log(.Warning, message: message, function: function, file: file, line: line)
}

func logInfo(message: @autoclosure () -> String, function: String = __FUNCTION__,
    file: String = __FILE__, line: UInt = __LINE__) {
        DDLog.log(.Info, message: message, function: function, file: file, line: line)
}

func logDebug(message: @autoclosure () -> String, function: String = __FUNCTION__,
    file: String = __FILE__, line: UInt = __LINE__) {
        DDLog.log(.Debug, message: message, function: function, file: file, line: line)
}

func logVerbose(message: @autoclosure () -> String, function: String = __FUNCTION__,
    file: String = __FILE__, line: UInt = __LINE__) {
        DDLog.log(.Verbose, message: message, function: function, file: file, line: line)
}