//
//  UIViewExtensionTestCase.swift
//  DemoTests
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import XCTest
import DSFoundation

class TestNib: UIView {
    
    @IBOutlet weak var label: UILabel!
}

class UIViewExtensionTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let _ = UIView.viewFromNib("TestNib", inBundle: Bundle.main)
    }
    
}
