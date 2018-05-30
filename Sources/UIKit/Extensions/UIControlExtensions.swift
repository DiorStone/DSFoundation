//
//  UIControlExtensions.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

extension UIControl: DSFoundationCompatible {}

/// UIControl Target-Action
///
///[参考链接](https://github.com/collinhundley/APTargets)
extension DSFoundation where Base: UIControl {
	
    /// 添加UIControlEvents闭包.
    ///
    /// 【不支持】
    ///  * applicationReserved
    ///  * systemReserved
    ///  * allEvents
    ///
    /// - Parameters:
    ///   - controlEvents: UIControlEvents
    ///   - action: Event回调(需要注意self的循环引用问题)
    public func addTarget(for controlEvents: UIControlEvents, action: @escaping ()->Void ) {
        self.base.addTarget(for: controlEvents, action: action)
    }
    
    /// 添加UIControlEvents闭包.
    ///
    /// 【不支持】
    ///  * applicationReserved
    ///  * systemReserved
    ///  * allEvents
    ///
    /// - Parameters:
    ///   - controlEvents: UIControlEvents
    ///   - action: Event回调(需要注意self的循环引用问题)
    public func addTarget(for controlEvents: UIControlEvents, action: @escaping (Base)->Void ) {
        self.base.addTarget(for: controlEvents, action: action)
    }
	
    /// 删除UIControlEvents闭包
    ///
    /// 【不支持】
    ///  * applicationReserved
    ///  * systemReserved
    ///  * allEvents
    ///
    /// - Parameter controlEvents: UIControlEvents
	public func removeTarget(for controlEvents: UIControlEvents) {
        self.base.removeTarget(for: controlEvents)
	}
}
