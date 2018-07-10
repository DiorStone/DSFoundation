//
//  PagingTestCase.swift
//  DemoTests
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//
import XCTest
import DSFoundation

class PagingTestCase: XCTestCase, Pagingable {
	
    lazy var customPage: Paging = Paging()
	
    override func setUp() {
        super.setUp()
		//配置全局的分页
		PagingConfig.default.startPage = 1
		PagingConfig.default.pageSize = 20;
//		//发起网络请求
//		//1.服务器返回总条数
//		let total = 100
//		self.paging.hasNextPage = self.paging.currentPage * self.paging.pageSize < total
//		//2.服务只返回数据条数
//		let datas: [String] = []
//		self.paging.hasNextPage = datas.count > 0
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDefaultValue() {
		//全局默认配置
		assert(PagingConfig.default.startPage == 1)
		assert(PagingConfig.default.pageSize == 20)
		
		assert(self.paging.currentPage == 1)
		assert(self.paging.pageSize == 20)
		//模块自定义当前分页
		self.paging.reset(startPage: 0, pageSize: 30)
		assert(self.paging.currentPage == 0)
		assert(self.paging.pageSize == 30)
		assert(self.paging.hasNextPage)
		
		self.paging.currentPage += 1;
		self.paging.hasNextPage = false
		assert(self.paging.currentPage == 1)
		assert(!self.paging.hasNextPage)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
	func testCustomValue() {
		assert(self.customPage.currentPage == 1)
		assert(self.customPage.pageSize == 20)
		//模块自定义当前分页
		self.customPage.reset(startPage: 0, pageSize: 30)
		assert(self.customPage.currentPage == 0)
		assert(self.customPage.pageSize == 30)
		assert(self.customPage.hasNextPage)
		
		self.customPage.currentPage += 1;
		self.customPage.hasNextPage = false
		assert(self.customPage.currentPage == 1)
		assert(!self.customPage.hasNextPage)
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
    
}
