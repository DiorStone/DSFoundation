//
//  ToastCenter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation

func test() {
    Toast(text: "登陆成功").show()
}

class Toast  {
    
    static let short: TimeInterval = 2.0
    static let long: TimeInterval = 3.5
    
    weak var operation: Operation?
    
    var text: String
    var delay: TimeInterval
    var duration: TimeInterval
    
    init(text: String, duration: TimeInterval, delay: TimeInterval) {
        self.text = text
        self.delay = delay
        self.duration = duration
    }
    
    convenience init(text: String, duration: TimeInterval = Toast.short) {
        self.init(text: text, duration: duration, delay: 0)
    }
    
    func show() {
        let operation = ToastOperation(self)
        
        ToastCenter.default.add(operation)
    }
    
    func cancel() {
        //check
//        operation?.cancel()
    }
}

class ToastOperation: Operation  {
    
    weak var toast: Toast?
    
    init(_ toast: Toast) {
        self.toast = toast
        super.init()
    }
    
    override func start() {
        guard self.isExecuting else {
            return
        }
        if Thread.isMainThread {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
        } else {
            main()
        }
    }
    
    override func main() {
        
    }
    
    override func cancel() {
        
    }
}

class ToastCenter {
    
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "org.diorstone.ToastCenter"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    static let `default` = ToastCenter()
    
    init() {
        
    }
    
    func add(_ toast: Operation)  {
        
        self.queue.addOperation(operation)
    }
    
    func cancelAll() {
        self.queue.cancelAllOperations()
    }
}
