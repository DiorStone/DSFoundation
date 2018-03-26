//
//  XcodeFormatter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

struct XcodeFormatter: Formatter {
    
    typealias FormatType = String
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    
    func format(log: Log) -> String {
        let level: String = {
            switch log.level {
            case .verbose:  return "◽️VERBOSE"
            case .debug:    return "◾️DEBUG  "
            case .info:     return "🔷INFO   "
            case .warn:     return "🔶WARN   "
            case .error:    return "❌ERROR  "
            }
        }()
        
        let timestamp = dateFormatter.string(from: log.date)
        let file = URL(string: log.file.description)?.deletingPathExtension()
        let string = "[\(timestamp)] \(level) \(file?.lastPathComponent ?? "???"):\(log.function) \(log.message)"
        return string
    }
}
