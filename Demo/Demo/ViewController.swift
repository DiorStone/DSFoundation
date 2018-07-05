//
//  ViewController.swift
//  Demo
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import UIKit
import DSFoundation

class ViewController: UIViewController, Pagingable {

	//1.需要显示总共有几页 7/8 服务器会返回总条数
	//2.服务器不返回,多一次请求
	var currentPage: Int = 0
	var pageSize: Int = 0
	var hasNextPage: Bool = true
	
	var total: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()
//		currentPage = 1
//		pageSize = 10
//		hasNextPage = true
		
		//请求接口后
		print("\(currentPage)/\(total!/pageSize)")
		
        let textFiled = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        textFiled.placeholder = "12323"
        self.view.addSubview(textFiled)
        DispatchQueue.main.async {
            for index in 0..<10000 {
                let toast = Toast(text: "登陆成功\(index)")
                toast.show()
            }
        }
        
//        for index in 0..<10000 {
//            let toast = Toast(text: "登陆成功\(index)")
//            toast.show()
////            toast.cancel()
//        }
//        for _ in 0..<10000 {
//            let toast = Toast(text: "登陆成功!\(index)")
//            toast.show()
//            toast.cancel()
//        }
        Toast(text: "登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111登陆成功!1111").show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }


}
