//
//  ViewController.swift
//  Demo
//
//  Created by Mrdaios on 2018/3/26.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

import UIKit
import DSFoundation

class ViewController: UIViewController, ActiveViewable {
    
    func activeController() -> UIViewController? {
        return self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
////        UIAlertView(title: "提示", message: UIDevice.current.identifierForVendor?.description, delegate: nil, cancelButtonTitle: "确定").show()
////        let viewController = UIAlertController(title: "<#T##String?#>", message: "<#T##String?#>", preferredStyle: UIAlertControllerStyle.actionSheet)
////        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
////            self?.present(viewController, animated: true, completion: nil)
////            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
////                print(Application.currentController())
////            }
////        }
//
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        button.backgroundColor =  UIColor.red
//        button.ds.addTarget(for: .touchUpInside) { sender in
//            print(1)
//        }
////        button.ds.addTarget(for: .touchUpOutside) { [weak self] in
////            print(2)
////            button.ds.removeTarget(for: .touchUpInside)
////        }
//
//        button.ds.addTarget(for: .touchUpOutside) { (sender) in
//
//        }
//        self.view.addSubview(button)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
                            self?.present(ViewController1(), animated: true, completion: nil)
                        }
                    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        UIAlertView(title: "提示", message: UIDevice.current.identifierForVendor?.description, delegate: nil, cancelButtonTitle: "确定").show()
        //        let viewController = UIAlertController(title: "<#T##String?#>", message: "<#T##String?#>", preferredStyle: UIAlertControllerStyle.actionSheet)
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
        //            self?.present(viewController, animated: true, completion: nil)
        //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
        //                print(Application.currentController())
        //            }
        //        }
        view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor =  UIColor.red
//        let action: (UIButton) -> Void =  { sender in
//
//        }
        //        button.ds.addTarget(for: .touchUpOutside) { [weak self] in
        //            print(2)
        //            button.ds.removeTarget(for: .touchUpInside)
        //        }
        
        button.addTarget1(for: [.touchDown]) { (sender) in

        }
        self.view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

