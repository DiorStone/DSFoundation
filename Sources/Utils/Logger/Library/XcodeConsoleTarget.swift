//
//  XcodeConsoleTarget.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

/// 终端
struct XcodeConsoleTarget: Target {
    
    private let lock = NSRecursiveLock()
    
    func write(formatted items: [String], completion: @escaping () -> Void) {
        items.forEach {
            lock.lock()
            print($0)
            lock.unlock()
        }
        completion()
    }
}
