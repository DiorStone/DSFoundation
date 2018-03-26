//
//  Plugin.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

protocol Plugin {
    
    func apply(log: Log) -> Log
}
