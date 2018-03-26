//
//  Target.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

protocol Target {
    
    associatedtype FormatType    
    func write(formatted items: [FormatType], completion: @escaping () -> Void)
}
