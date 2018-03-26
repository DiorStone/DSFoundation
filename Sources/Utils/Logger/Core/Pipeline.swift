//
//  Pipeline.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

/**
 * Logs => Plugins => Formatter => Targets
 */
class Pipeline {
    
    private let lock = NSRecursiveLock()
    private var plugins: [Plugin] = []
    private var isWritingTarget: Bool = false
    private var writeProcess: (([Log]) -> Void)?
    
    init<F, T>(targetConfiguration: TargetConfiguration<F, T>) {
        let formatter = targetConfiguration.formatter
        let target = targetConfiguration.target
        
        self.writeProcess = { [weak self] logs in
            guard let `self` = self else { return }
            guard logs.isEmpty == false else { return }

            let group = DispatchGroup()
            group.enter()
            
            /// apply formatter
            let formattedLogs = logs.map(formatter.format(log: ))
            
            /// write to target
            target.write(formatted: formattedLogs, completion: {
                group.leave()
            })
             _ = group.wait(timeout: DispatchTime.now() + .seconds(10))
            self.isWritingTarget = false
        }
    }
    
    
    func write(log: Log) {
        self.lock.lock()
        defer {
            self.lock.unlock()
        }
        
        /// apply plugins
        let pluginedLog = self.plugins.reduce(log) { log, plugin in
            plugin.apply(log: log)
        }
        guard pluginedLog.isActive == true else {
            return
        }
        
        self.__write([pluginedLog])
    }
    
    @inline(__always)
    private func __write(_ logs: [Log]) {
        lock.lock()
        defer {
            lock.unlock()
        }
        self.writeProcess?(logs)
    }
    
    internal struct TargetConfiguration<F: Formatter, T: Target> where F.FormatType == T.FormatType {
        let formatter: F
        let target: T
    }
}
