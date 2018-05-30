//
//  TargetAction.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

class TargetAction {

    weak var sender: UIControl?
    var action: Any
    var invoke: (TargetAction)->Void

    init(sender: UIControl?, action: Any, invoke: @escaping (TargetAction)->Void ) {
        self.sender = sender
        self.action = action
        self.invoke = invoke
    }
}

protocol TargetActionable {

    /// event -> actions
    var actionRegistry: [UInt:[Any]] { get set }
}

extension TargetActionable {

    mutating func addAction(event: UIControlEvents, action: Any) {
        if var actions = self.actionRegistry[event.rawValue] {
            actions.append(action)
            self.actionRegistry[event.rawValue] = actions
        } else {
            self.actionRegistry[event.rawValue] = [action]
        }
    }

    mutating func removeAction(event: UIControlEvents) {
        self.actionRegistry[event.rawValue] = []
    }
}

extension TargetActionable where Self: UIControl {

    mutating func addTarget(for controlEvents: UIControlEvents, action: Any ) {
        let targetAction = TargetAction(sender: self, action: action) { target in
            if let function = target.action as? ()->Void {
                function()
            } else if let function = target.action as? (Self)->Void {
                function(target.sender as! Self)
            }
        }
        if controlEvents.contains(.touchDown) {
            self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
            addAction(event: .touchDown, action: targetAction)
        }
        if controlEvents.contains(.touchDownRepeat) {
            self.addTarget(self, action: #selector(touchDownRepeat(sender:)), for: .touchDownRepeat)
            addAction(event: .touchDownRepeat, action: targetAction)
        }
        if controlEvents.contains(.touchDragInside) {
            self.addTarget(self, action: #selector(touchDragInside(sender:)), for: .touchDragInside)
            addAction(event: .touchDragInside, action: targetAction)
        }
        if controlEvents.contains(.touchDragOutside) {
            self.addTarget(self, action: #selector(touchDragOutside(sender:)), for: .touchDragOutside)
            addAction(event: .touchDragOutside, action: targetAction)
        }
        if controlEvents.contains(.touchDragEnter) {
            self.addTarget(self, action: #selector(touchDragEnter(sender:)), for: .touchDragEnter)
            addAction(event: .touchDragEnter, action: targetAction)
        }
        if controlEvents.contains(.touchDragExit) {
            self.addTarget(self, action: #selector(touchDragExit(sender:)), for: .touchDragExit)
            addAction(event: .touchDragExit, action: targetAction)
        }
        if controlEvents.contains(.touchUpInside) {
            self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
            addAction(event: .touchUpInside, action: targetAction)
        }
        if controlEvents.contains(.touchUpOutside) {
            self.addTarget(self, action: #selector(touchUpOutside(sender:)), for: .touchUpOutside)
            addAction(event: .touchUpOutside, action: targetAction)
        }
        if controlEvents.contains(.touchCancel) {
            self.addTarget(self, action: #selector(touchCancel(sender:)), for: .touchCancel)
            addAction(event: .touchCancel, action: targetAction)
        }
        if controlEvents.contains(.valueChanged) {
            self.addTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
            addAction(event: .valueChanged, action: targetAction)
        }
        if #available(iOS 9.0, *) {
            if controlEvents.contains(.primaryActionTriggered) {
                self.addTarget(self, action: #selector(primaryActionTriggered(sender:)), for: .primaryActionTriggered)
                addAction(event: .primaryActionTriggered, action: targetAction)
            }
        }
        if controlEvents.contains(.editingDidBegin) {
            self.addTarget(self, action: #selector(editingDidBegin(sender:)), for: .editingDidBegin)
            addAction(event: .editingDidBegin, action: targetAction)
        }
        if controlEvents.contains(.editingChanged) {
            self.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
            addAction(event: .editingChanged, action: targetAction)
        }
        if controlEvents.contains(.editingDidEnd) {
            self.addTarget(self, action: #selector(editingDidEnd(sender:)), for: .editingDidEnd)
            addAction(event: .editingDidEnd, action: targetAction)
        }
        if controlEvents.contains(.editingDidEndOnExit) {
            self.addTarget(self, action: #selector(editingDidEndOnExit(sender:)), for: .editingDidEndOnExit)
            addAction(event: .editingDidEndOnExit, action: targetAction)
        }
        if controlEvents.contains(.allTouchEvents) {
            self.addTarget(self, action: #selector(allTouchEvents(sender:)), for: .allTouchEvents)
            addAction(event: .allTouchEvents, action: targetAction)
        }
        if controlEvents.contains(.allEditingEvents) {
            self.addTarget(self, action: #selector(allEditingEvents(sender:)), for: .allEditingEvents)
            addAction(event: .allEditingEvents, action: targetAction)
        }
    }

    mutating func removeTarget(for controlEvents: UIControlEvents) {
        if controlEvents.contains(.touchDown) {
            self.removeTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
            removeAction(event: .touchDown)
        }
        if controlEvents.contains(.touchDownRepeat) {
            self.removeTarget(self, action: #selector(touchDownRepeat(sender:)), for: .touchDownRepeat)
            removeAction(event: .touchDownRepeat)
        }
        if controlEvents.contains(.touchDragInside) {
            self.removeTarget(self, action: #selector(touchDragInside(sender:)), for: .touchDragInside)
            removeAction(event: .touchDragInside)
        }
        if controlEvents.contains(.touchDragOutside) {
            self.removeTarget(self, action: #selector(touchDragOutside(sender:)), for: .touchDragOutside)
            removeAction(event: .touchDragOutside)
        }
        if controlEvents.contains(.touchDragEnter) {
            self.removeTarget(self, action: #selector(touchDragEnter(sender:)), for: .touchDragEnter)
            removeAction(event: .touchDragEnter)
        }
        if controlEvents.contains(.touchDragExit) {
            self.removeTarget(self, action: #selector(touchDragExit(sender:)), for: .touchDragExit)
            removeAction(event: .touchDragExit)
        }
        if controlEvents.contains(.touchUpInside) {
            self.removeTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
            removeAction(event: .touchUpInside)
        }
        if controlEvents.contains(.touchUpOutside) {
            self.removeTarget(self, action: #selector(touchUpOutside(sender:)), for: .touchUpOutside)
            removeAction(event: .touchUpOutside)
        }
        if controlEvents.contains(.touchCancel) {
            self.removeTarget(self, action: #selector(touchCancel(sender:)), for: .touchCancel)
            removeAction(event: .touchCancel)
        }
        if controlEvents.contains(.valueChanged) {
            self.removeTarget(self, action: #selector(valueChanged(sender:)), for: .valueChanged)
            removeAction(event: .valueChanged)
        }
        if #available(iOS 9.0, *) {
            if controlEvents.contains(.primaryActionTriggered) {
                self.removeTarget(self, action: #selector(primaryActionTriggered(sender:)), for: .primaryActionTriggered)
                removeAction(event: .primaryActionTriggered)
            }
        }
        if controlEvents.contains(.editingDidBegin) {
            self.removeTarget(self, action: #selector(editingDidBegin(sender:)), for: .editingDidBegin)
            removeAction(event: .editingDidBegin)
        }
        if controlEvents.contains(.editingChanged) {
            self.removeTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
            removeAction(event: .editingChanged)
        }
        if controlEvents.contains(.editingDidEnd) {
            self.removeTarget(self, action: #selector(editingDidEnd(sender:)), for: .editingDidEnd)
            removeAction(event: .editingDidEnd)
        }
        if controlEvents.contains(.editingDidEndOnExit) {
            self.removeTarget(self, action: #selector(editingDidEndOnExit(sender:)), for: .editingDidEndOnExit)
            removeAction(event: .editingDidEndOnExit)
        }
        if controlEvents.contains(.allTouchEvents) {
            self.removeTarget(self, action: #selector(allTouchEvents(sender:)), for: .allTouchEvents)
            removeAction(event: .allTouchEvents)
        }
        if controlEvents.contains(.allEditingEvents) {
            self.removeTarget(self, action: #selector(allEditingEvents(sender:)), for: .allEditingEvents)
            removeAction(event: .allEditingEvents)
        }
    }
}

extension UIControl: TargetActionable {

     var actionRegistry: [UInt:[Any]]  {
        set {
            setAssociatedValue(object: self, associatedValue: newValue)
        }
        get {
            return getAssociatedValue(object: self, initialValue: [:])
        }
    }

    func triggerAction(forObject sender: UIControl, event: UIControlEvents) {
        sender.actionRegistry[event.rawValue]?.forEach({
            if let function = $0 as? TargetAction {
                function.invoke(function)
            }
        })
    }

    //MARK: - UIControlEvents

    @objc fileprivate func touchDown(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDown)
    }

    @objc fileprivate func touchDownRepeat(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDownRepeat)
    }

    @objc fileprivate func touchDragInside(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDragInside)
    }

    @objc fileprivate func touchDragOutside(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDragOutside)
    }

    @objc fileprivate func touchDragEnter(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDragEnter)
    }

    @objc fileprivate func touchDragExit(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchDragExit)
    }

    @objc fileprivate func touchUpInside(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchUpInside)
    }

    @objc fileprivate func touchUpOutside(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchUpOutside)
    }

    @objc fileprivate func touchCancel(sender: UIControl) {
        triggerAction(forObject: sender, event: .touchCancel)
    }

    @objc fileprivate func valueChanged(sender: UIControl) {
        triggerAction(forObject: sender, event: .valueChanged)
    }

    @objc fileprivate func primaryActionTriggered(sender: UIControl) {
        if #available(iOS 9.0, *) {
            triggerAction(forObject: sender, event: .primaryActionTriggered)
        }
    }

    @objc fileprivate func editingDidBegin(sender: UIControl) {
        triggerAction(forObject: sender, event: .editingDidBegin)
    }

    @objc fileprivate func editingChanged(sender: UIControl) {
        triggerAction(forObject: sender, event: .editingChanged)
    }

    @objc fileprivate func editingDidEnd(sender: UIControl) {
        triggerAction(forObject: sender, event: .editingDidEnd)
    }

    @objc fileprivate func editingDidEndOnExit(sender: UIControl) {
        triggerAction(forObject: sender, event: .editingDidEndOnExit)
    }

    @objc fileprivate func allTouchEvents(sender: UIControl) {
        triggerAction(forObject: sender, event: .allTouchEvents)
    }

    @objc fileprivate func allEditingEvents(sender: UIControl) {
        triggerAction(forObject: sender, event: .allEditingEvents)
    }
}
