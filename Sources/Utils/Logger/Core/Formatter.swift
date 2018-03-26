//
//  Formatter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

protocol Formatter {
    
    associatedtype FormatType
    func format(log: Log) -> FormatType
}
