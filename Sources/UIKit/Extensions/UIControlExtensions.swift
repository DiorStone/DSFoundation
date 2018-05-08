//
//  UIControlExtensions.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

extension UIControl: DSFoundationCompatible {}

/// UIControl Target-Action
///
///[参考链接](https://github.com/collinhundley/APTargets)
extension DSFoundation where Base: UIControl {
	
	public func addTarget(for controlEvents: UIControlEvents, action blockAction: ()->Void ) {
		var action: String!
		if controlEvents.contains(.touchDown) {
			action = "touchDown"
		} else if controlEvents.contains(.touchDownRepeat) {
			action = "touchDownRepeat"
		} else if controlEvents.contains(.touchDragInside) {
			action = "touchDragInside"
		} else if controlEvents.contains(.touchDragOutside) {
			action = "touchDragOutside"
		} else if controlEvents.contains(.touchDragEnter) {
			action = "touchDragEnter"
		} else if controlEvents.contains(.touchDragExit) {
			action = "touchDragExit"
		} else if controlEvents.contains(.touchUpInside) {
			action = "touchUpInside"
		} else if controlEvents.contains(.touchUpOutside) {
			action = "touchUpOutside"
		} else if controlEvents.contains(.touchCancel) {
			action = "touchCancel"
		} else if controlEvents.contains(.valueChanged) {
			action = "valueChanged"
//		} else if controlEvents.contains(.primaryActionTriggered) {
		} else if controlEvents.contains(.editingDidBegin) {
			action = "editingDidBegin"
		} else if controlEvents.contains(.editingChanged) {
			action = "editingChanged"
		} else if controlEvents.contains(.editingDidEnd) {
			action = "editingDidEnd"
		} else if controlEvents.contains(.editingDidEndOnExit) {
			action = "editingDidEndOnExit"
		} else if controlEvents.contains(.allTouchEvents) {
			action = "allTouchEvents"
		} else if controlEvents.contains(.allEditingEvents) {
			action = "allEditingEvents"
		} else if controlEvents.contains(.applicationReserved) {
			action = "applicationReserved"
		} else if controlEvents.contains(.systemReserved) {
			action = "systemReserved"
		} else if controlEvents.contains(.allEvents) {
			action = "allEvents"
		}
		
		if var actions = self.base.actionRegistry[action] {
			actions.append(blockAction)
			self.base.actionRegistry[action] = actions
		} else {
			self.base.actionRegistry[action] = [blockAction]
		}
		self.base.addTarget(self.base, action: Selector(action), for: .touchDown)
	}
	
	public func removeTarget(for controlEvents: UIControlEvents) {
		//TODO:
	}
}

extension UIControl {
	
	fileprivate var actionRegistry: [String:[Any]]  {
		set {
			setAssociatedValue(object: self, associatedValue: newValue)
		}
		
		get {
			return getAssociatedValue(object: self, initialValue: [:])
		}
	}
	
	@objc fileprivate func touchDown() {
		self.actionRegistry["touchDown"]?.forEach({
			($0 as? ()->Void)?()
		})
	}
}
