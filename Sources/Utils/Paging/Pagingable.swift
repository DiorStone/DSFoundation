//
//  Pagingable.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

public protocol Pagingable {
	
	var currentPage: Int { get set }
	var pageSize: Int { get set }
	var hasNextPage: Bool { get set }
}
