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
	
    public func addTarget(for controlEvents: UIControlEvents, action: @escaping ()->Void ) {
        print(action)
//        self.base.addTarget(for: controlEvents, action: action)
    }
    
    public func addTarget(for controlEvents: UIControlEvents, action: @escaping (Base)->Void ) {
//        self.base.addTarget(for: controlEvents, action: action)
        self.base.addTarget1(for: controlEvents, action: action)
    }
	
	public func removeTarget(for controlEvents: UIControlEvents) {
        self.base.removeTarget(for: controlEvents)
	}
}
