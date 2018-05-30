//
//  UIViewControllerExtensions.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

public protocol ActiveViewable {
    
    /// 当前活动的ViewController
    func activeController() -> UIViewController?
}

extension ActiveViewable where Self: UINavigationController {
    
    public func activeController() -> UIViewController? {
        return self.visibleViewController
    }
}

extension ActiveViewable where Self: UITabBarController {
    
    public func activeController() -> UIViewController? {
        return self.selectedViewController
    }
}

extension UINavigationController: ActiveViewable {}
extension UITabBarController: ActiveViewable {}

fileprivate func recursionController(with viewController: UIViewController?) -> UIViewController? {
    var currentController: UIViewController? = nil
    //容器递归
    if viewController is UINavigationController {
        currentController = (viewController as! UINavigationController).activeController()
        currentController = recursionController(with: currentController)
    }
    else if viewController is UITabBarController {
        currentController = (viewController as! UITabBarController).activeController()
        currentController = recursionController(with: currentController)
    }
    else if ((viewController?.childViewControllers.count ?? 0 > 0) && (viewController is ActiveViewable)) {
        currentController = (viewController as! ActiveViewable).activeController()
        currentController = recursionController(with: currentController)
    }
    else {
        currentController = viewController
    }
    //present递归
    if let presentedViewController = currentController?.presentedViewController {
        currentController = recursionController(with: presentedViewController)
    }
    return currentController
}

extension Application {
    
    /// 当前ViewController
    ///
    /// 自定义容器请参考**Activeable**
    ///
    /// - Returns: 返回当前ViewController(自动遍历容器和PresentController)
    public static func currentController() -> UIViewController? {
        let viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        return recursionController(with: viewController)
    }
}

// MARK: Deprecated

extension NSObject {
    
    /// 当前ViewController
    ///
    /// 自定义容器请参考**Activeable**
    ///
    /// - Returns: 返回当前ViewController(自动遍历容器和PresentController)
    @available(*, deprecated, message: "Use Application.currentController() api instead.")
    public func currentController() -> UIViewController? {
        let viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        return recursionController(with: viewController)
    }
}

