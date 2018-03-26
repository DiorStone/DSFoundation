//
//  LoggerTestCase.swift
//  DemoTests
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import XCTest
import DSFoundation

class LoggerTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
        Logger.verbose("verbose")
        Logger.debug("debug")
        Logger.info("info")
        Logger.warn("warn")
        Logger.error("error")
    }
}
