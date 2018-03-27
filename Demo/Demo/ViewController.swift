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
        // Do any additional setup after loading the view, typically from a nib.
//        UIAlertView(title: "<#T##String?#>", message: "<#T##String?#>", delegate: nil, cancelButtonTitle: "<#T##String?#>").show()
        let viewController = UIAlertController(title: "<#T##String?#>", message: "<#T##String?#>", preferredStyle: UIAlertControllerStyle.actionSheet)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
            self?.present(viewController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
                print(self?.currentController())
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

