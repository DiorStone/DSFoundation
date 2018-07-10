//
//  Pagingable.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

public protocol Pagingable {
	
    /// 分页配置
    var paging: Paging { get }
}


extension Pagingable {
	
	/// 分页配置
    public var paging: Paging {
		return getAssociatedValue(object: self, initialValue: Paging())
    }
}

/// 分页配置
public class Paging {
    
    /// 当前页码
    public var currentPage: Int
    
    /// 分页大小
    public var pageSize: Int
    
    /// 是否有下一页
    public var hasNextPage: Bool
    
    public init(startPage: Int = PagingConfig.default.startPage,
                pageSize: Int  = PagingConfig.default.pageSize) {
        self.currentPage = startPage
        self.pageSize = pageSize
        self.hasNextPage = true
    }
    
    /// 重置分页配置
    ///
    /// - Parameters:
    ///   - startPage: startPage
    ///   - pageSize: pageSize
    public func reset(startPage: Int = PagingConfig.default.startPage,
                      pageSize: Int  = PagingConfig.default.pageSize) {
        self.currentPage = startPage
        self.pageSize = pageSize
        self.hasNextPage = true
    }
}

/// 分页全局配置信息,可以在app初始化好后配置
public class PagingConfig {
    
    /// 起始页,默认为0.
    public var startPage: Int = 0
    
    /// 分页大小,默认为10.
    public var pageSize: Int = 10
    
    /// 全局分页配置
    public static let `default`: PagingConfig = PagingConfig()
}
