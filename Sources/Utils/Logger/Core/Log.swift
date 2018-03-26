//
//  Log.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

/// 日志
struct Log {
    
    public enum Level {
        case verbose
        case debug
        case info
        case warn
        case error
    }
    
    var level: Level
    var date: Date
    var file: String
    var function: String
    var line: Int
    var message: Any
    var isActive: Bool = true
    
    init(level: Log.Level, date: Date, file: String, function: String, line: Int, message: Any) {
        self.level = level
        self.date = date
        self.file = file
        self.function = function
        self.line = line
        self.message = message
    }
}
