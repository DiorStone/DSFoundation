//
//  XcodePlugin.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

struct XcodePlugin: Plugin {
    
    func apply(log: Log) -> Log {
        var activeLog = log
        switch activeLog.level {
        case .verbose, .debug:
            activeLog.isActive = false
        default:
            break
        }
        
        #if DEBUG
        activeLog.isActive = true
        #endif
        return activeLog
    }
}
