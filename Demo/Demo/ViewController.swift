//
//  ViewController.swift
//  Demo
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import UIKit
import DSFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
