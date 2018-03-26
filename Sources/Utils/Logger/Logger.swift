//
//  Logger.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

/// Log服务
///
/// 参考链接
///
///* [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver/blob/master/Sources/SwiftyBeaver.swift)
///* [Bulk](https://github.com/muukii/Bulk)
///
/// Tips:
///* verbose和debug暂时没区别
///* 慎用info、warn、error
///* 暂时只支持xcode输出
public struct Logger {

    /// 开发调试过程中一些详细信息，不编译进产品中，只在开发阶段使用
    public static func verbose(_ message: @autoclosure @escaping () -> Any,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line) {
        __write(Log.Level.verbose, message, file, function, line)
    }
    
    /// 开发调试过程中一些调试信息，不编译进产品中，只在开发阶段使用
    public static func debug(_ message: @autoclosure @escaping () -> Any,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        __write(Log.Level.debug, message, file, function, line)
    }
    
    /// 记录info类型日志
    public static func info(_ message: @autoclosure @escaping () -> Any,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line) {
        __write(Log.Level.info, message, file, function, line)
    }
    
    /// 记录warn类型日志
    public static func warn(_ message: @autoclosure @escaping () -> Any,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line) {
        __write(Log.Level.warn, message, file, function, line)
    }
    
    /// 记录error类型日志
    public static func error(_ message: @autoclosure @escaping () -> Any,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        __write(Log.Level.error, message, file, function, line)
    }
}


extension Logger {
    
    /// 暂时不公开
    static var pipelines: [Pipeline] = [
        Pipeline(targetConfiguration:Pipeline.TargetConfiguration.init(formatter: XcodeFormatter(),target: XcodeConsoleTarget()))
    ]
    
    @inline(__always)
    fileprivate static func __write(_ level: Log.Level,
                                    _ message: @autoclosure @escaping () -> Any,
                                    _ file: String,
                                    _ function: String,
                                    _ line: Int) {
        let log = Log(level: level, date: Date(), file: file, function: function, line: line, message: message())
        pipelines.forEach { pipeline in
            pipeline.write(log: log)
        }
    }
    
}
