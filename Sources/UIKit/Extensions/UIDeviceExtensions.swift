//
//  UIDeviceExtensions.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

// MARK: - 硬件种类判断
extension UIDevice: DSFoundationCompatible {}
extension DSFoundation where Base: UIDevice {
    
    /// 是否是iPhone系列
    public var isPhone: Bool {
        if ((self.base.model.range(of: "iPhone", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil) ||
            (self.base.model.range(of: "iPod", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)  ||
            (self.base.model.range(of: "iTouch", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)) {
            return true
        } else {
            return false
        }
    }
    
    /// 是否是iPad系列
    public var isPad: Bool {
        if ((self.base.model.range(of: "iPad", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)) {
            return true
        } else {
            return false
        }
    }
}

// MARK: Deprecated

extension UIDevice {
    
    /// 是否是iPhone系列
    @available(*, deprecated, message: "Use UIDevice.current.ds.isPhone API instead.")
    public var isPhone: Bool {
        if ((self.model.range(of: "iPhone", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil) ||
            (self.model.range(of: "iPod", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)  ||
            (self.model.range(of: "iTouch", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)) {
            return true
        } else {
            return false
        }
    }
    
    /// 是否是iPad系列
    @available(*, deprecated, message: "Use UIDevice.current.ds.isPad API instead.")
    public var isPad: Bool {
        if ((self.model.range(of: "iPad", options: String.CompareOptions.caseInsensitive, range: nil, locale: nil) != nil)) {
            return true
        } else {
            return false
        }
    }
}
