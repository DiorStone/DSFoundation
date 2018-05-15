//
//  ToastCenter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation
import UIKit

func test() {
    Toast(text: "登陆成功").show()
}

public class Toast  {
    
    public static let short: TimeInterval = 2.0
    public static let long: TimeInterval = 3.5
    
    private weak var operation: Operation?
    
    var text: String
    var delay: TimeInterval
    var duration: TimeInterval
    
    public init(text: String, duration: TimeInterval, delay: TimeInterval) {
        self.text = text
        self.delay = delay
        self.duration = duration
    }
    
    public convenience init(text: String, duration: TimeInterval = Toast.short) {
        self.init(text: text, duration: duration, delay: 0)
    }
    
    public func show() {
        let toastOperation = Operation(self)
        Manager.default.add(toastOperation)
		operation = toastOperation
    }
    
    public func cancel() {
        //check
        operation?.cancel()
    }
	
	class View: UIKit.UIView {
		
		private let backgroundView: UIView = {
			let view = UIView()
			view.backgroundColor = UIColor(white: 0, alpha: 0.7)
			view.layer.cornerRadius = 5
			view.clipsToBounds = true
			return view
		}()
		
		private let textLabel: UILabel = {
			let view = UILabel()
			view.textColor = .white
			view.backgroundColor = .clear
			view.font = {
				switch UIDevice.current.userInterfaceIdiom {
				case .pad: return .systemFont(ofSize: 16)
				case .tv: return .systemFont(ofSize: 20)
					//			case .unspecified: return .systemFont(ofSize: 12)
					//			case .phone: return .systemFont(ofSize: 12)
				//			case .carPlay: return .systemFont(ofSize: 12)
				default: return .systemFont(ofSize: 12)
				}
			}()
			view.numberOfLines = 0
			view.textAlignment = .center
			return view
		}()
		
		init() {
			super.init(frame: .zero)
			self.isUserInteractionEnabled = false
			self.addSubview(self.backgroundView)
			self.addSubview(self.textLabel)
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		override func layoutSubviews() {
			super.layoutSubviews()
		}
	}
	
	class Operation: Foundation.Operation  {
		
		var toast: Toast
		var view: View = View()
		
		private var _executing = false
		override var isExecuting: Bool {
			get {
				return self._executing;
			}
			set {
				self.willChangeValue(forKey: "isExecuting")
				self._executing = newValue
				self.didChangeValue(forKey: "isExecuting")
			}
		}
		
		private var _finished = false
		override var isFinished: Bool {
			get {
				return self._finished;
			}
			set {
				self.willChangeValue(forKey: "isFinished")
				self._finished = newValue
				self.didChangeValue(forKey: "isFinished")
			}
		}
		
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
			self.isExecuting = true
			OperationQueue.main.addOperation {
				self.view.setNeedsLayout()
				self.view.alpha = 0
				Window.default.addSubview(self.view)
				UIView.animate(
					withDuration: 0.5,
					delay: self.toast.delay,
					options: .beginFromCurrentState,
					animations: {
						self.view.alpha = 1
				}, completion: { (_) in
					UIView.animate(
						withDuration: self.toast.duration,
						animations: {
							self.view.alpha = 1.0001
					}, completion: { (_) in
						UIView.animate(
							withDuration: 0.5,
							animations: {
								self.view.alpha = 0
						}, completion: { (_) in
							self.view.removeFromSuperview()
						})
					})
				})
			}
		}
		
		override func cancel() {
			
		}
		
	}
	
	class Manager {
		
		private let queue: OperationQueue = {
			let queue = OperationQueue()
			queue.name = "org.diorstone.ToastCenter"
			queue.maxConcurrentOperationCount = 1
			return queue
		}()
		
		static let `default` = Manager()
		
		init() {
			
		}
		
		func add(_ operation: Operation)  {
			self.queue.addOperation(operation)
		}
		
		func cancelAll() {
			self.queue.cancelAllOperations()
		}
	}
	
	class Window: UIKit.UIWindow {
		
		static let `default` = Window(frame: UIScreen.main.bounds)
		
		override var rootViewController: UIViewController? {
			get {
				guard let firstWindow = UIApplication.shared.delegate?.window else { return nil }
				return firstWindow is Window ? nil : firstWindow?.rootViewController
			}
			set { /* Do nothing */ }
		}
	}
}
