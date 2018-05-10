//
//  DSFoundation.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

/**
 TODO:
 1.多个应用模块配置信息如何共享
 
 **/

/// 参考KingFisher避免方法重复
public final class DSFoundation<Base> {
    
    internal var base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

public protocol DSFoundationCompatible {
    associatedtype CompathibleType
    var ds: CompathibleType { get }
}

public extension DSFoundationCompatible {
    
    public var ds: DSFoundation<Self> {
        get {
            return DSFoundation(self)
        }
    }
}
