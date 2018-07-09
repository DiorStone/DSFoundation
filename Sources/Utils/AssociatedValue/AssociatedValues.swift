//
//  AssociatedValues.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import ObjectiveC.runtime

/// Associated
///
/// 参考链接
///
///* [AssociatedValues](https://github.com/bradhilton/AssociatedValues/blob/master/AssociatedValues/AssociatedValues.swift)

//MARK: Associated-get

func getAssociatedValue<T>(object: Any, key: String = #function) -> T? {
    return (objc_getAssociatedObject(object, key.address) as? AssociatedValue)?.value as? T
}

func getAssociatedValue<T>(object: Any, initialValue: @autoclosure () -> T, key: String = #function) -> T {
    return getAssociatedValue(object: object, key: key) ?? setAndReturn(initialValue: initialValue(), key: key, object: object)
}

fileprivate func setAndReturn<T>(initialValue: T, key: String, object: Any) -> T {
    setAssociatedValue(object: object, associatedValue: initialValue, key: key)
    return initialValue
}

//MARK: Associated-set
func setAssociatedValue<T>(object: Any, associatedValue: T?, key: String = #function) {
    set(associatedValue: AssociatedValue(associatedValue), key: key, object: object)
}

func setAssociatedValue<T : AnyObject>(object: Any, associatedValue: T?, key: String = #function) {
    set(associatedValue: AssociatedValue(weak: associatedValue), key: key, object: object)
}

private func set(associatedValue: AssociatedValue, key: String, object: Any) {
    objc_setAssociatedObject(object, key.address, associatedValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

extension String {
    
    fileprivate var address: UnsafeRawPointer {
        return UnsafeRawPointer(bitPattern: abs(hashValue))!
    }
}

private class AssociatedValue {
    
    weak var _weakValue: AnyObject?
    var _value: Any?
    
    var value: Any? {
        return _weakValue ?? _value
    }
    
    init(_ value: Any?) {
        _value = value
    }
    
    init(weak: AnyObject?) {
        _weakValue = weak
    }
}
