//
//  UIViewExtensions.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation
import UIKit

//MARK: nib

/// NibLoadableView
public protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    
    fileprivate static func loadNibViews(_ nibName: String, _ inBundle: Bundle) -> [UIView] {
        let nib = UINib(nibName: nibName, bundle: inBundle)
        return nib.instantiate(withOwner: self, options: nil).flatMap({ $0 as? UIView })
    }
    
    /// 从xib加载view
    ///
    /// - Parameters:
    ///   - nibName: xib名称,默认String(describing: self).components(separatedBy: ".").last!
    ///   - inBundle: Bundle,默认Bundle(for: self)
    /// - Returns: View
    public static func viewFromNib(_ nibName: String? = nil, inBundle: Bundle? = nil) -> Self? {
        let nibName = nibName ?? String(describing: self).components(separatedBy: ".").last!
        var bundle = inBundle ?? Bundle(for: self)
        
        //TODO: system UIView?
        if bundle.bundlePath.contains("System/Library") {
            bundle = Bundle.main
        }
        for view in self.loadNibViews(nibName, bundle) {
            if view is Self {
                return view as? Self
            }
        }
        return nil
    }
}

extension UIView: NibLoadableView {}
