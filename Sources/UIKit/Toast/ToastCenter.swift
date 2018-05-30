//
//  ToastCenter.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import Foundation
import UIKit

public class Toast  {
    
    // MARK: toast时长
    public static let short: TimeInterval = 2.0
    public static let long: TimeInterval = 3.5
    
    /// 显示时长
    public var text: String
    
    var delay: TimeInterval
    var duration: TimeInterval
    
    private weak var operation: Operation?
    
    /// 构建Toast
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - duration: 显示时长
    ///   - delay: 延时显示delay
    public init(text: String, duration: TimeInterval, delay: TimeInterval) {
        self.text = text
        self.delay = delay
        self.duration = duration
    }
    
    /// 构建Toast
    ///
    /// - Parameters:
    ///   - text: 文本
    ///   - duration: 显示时长
    public convenience init(text: String, duration: TimeInterval = Toast.short) {
        self.init(text: text, duration: duration, delay: 0)
    }
    
    /// 显示Toast
    public func show() {
        if operation == nil {
            let toastOperation = Operation(self)
            Manager.default.add(toastOperation)
            operation = toastOperation            
        }
    }
    
    /// 关闭Toast
    public func cancel() {
        operation?.cancel()
    }
	
	class View: UIKit.UIView {
        
        var textInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        
        var bottomOffset: CGFloat = {
            let orientation = UIApplication.shared.statusBarOrientation
            var offset: CGFloat = 0.0
            if orientation.isPortrait {
                offset = {
                    switch UIDevice.current.userInterfaceIdiom {
                    case .pad: return 60
                    case .tv: return 90
                    default: return 30
                    }
                }()
            } else {
                offset = {
                    switch UIDevice.current.userInterfaceIdiom {
                    case .pad: return 40
                    case .tv: return 60
                    default: return 20
                    }
                }()
            }
            return offset
        }()
		
		private let backgroundView: UIView = {
			let view = UIView()
			view.backgroundColor = UIColor(white: 0, alpha: 0.7)
			view.layer.cornerRadius = 12
			view.clipsToBounds = true
			return view
		}()
		
		let textLabel: UILabel = {
			let view = UILabel()
			view.textColor = .white
			view.backgroundColor = .clear
			view.font = {
				switch UIDevice.current.userInterfaceIdiom {
				case .pad: return .systemFont(ofSize: 16)
				case .tv: return .systemFont(ofSize: 20)
				default: return .systemFont(ofSize: 12)
				}
			}()
			view.numberOfLines = 0
			view.textAlignment = .center
            view.lineBreakMode = .byCharWrapping
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
            let containerSize = Window.default.frame.size
            let constraintSize = CGSize(width: containerSize.width * (280.0/320.0),
                                        height: CGFloat.greatestFiniteMagnitude)
            let textLabelSize = self.textLabel.sizeThatFits(constraintSize)
            self.textLabel.frame = CGRect(x: self.textInsets.left,
                                          y: self.textInsets.top,
                                          width: textLabelSize.width,
                                          height: textLabelSize.height)
            self.backgroundView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: textLabelSize.width + self.textInsets.left + self.textInsets.right,
                                               height: textLabelSize.height + self.textInsets.top + self.textInsets.bottom)
            
            var x: CGFloat = 0
            var y: CGFloat = self.bottomOffset
            let width: CGFloat = containerSize.width
            let height: CGFloat =  containerSize.height
            
            let backgroundViewSize = self.backgroundView.frame.size
            x = (width - backgroundViewSize.width) * 0.5
            y = height - (backgroundViewSize.height + y)
            
            self.frame = CGRect(x: x,
                                y: y,
                                width: backgroundView.frame.width,
                                height: backgroundView.frame.height)
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

        private var _cancelled = false
        override var isCancelled: Bool {
            get {
                return self._cancelled;
            }
            set {
                self.willChangeValue(forKey: "isCancelled")
                self._cancelled = newValue
                self.didChangeValue(forKey: "isCancelled")
            }
        }
		
		init(_ toast: Toast) {
			self.toast = toast
            self.view.textLabel.text = toast.text
			super.init()
		}
		
		override func start() {
            guard self.isCancelled == false else {
                self.finish()
                return
            }
            guard self.isExecuting == false else {
                return
            }
            if !Thread.isMainThread {
                DispatchQueue.main.async { [weak self] in
                    self?.start()
                }
            } else {
                main()
            }
		}
		
		override func main() {
            self.isExecuting = true
            self.view.setNeedsLayout()
            self.view.alpha = 0
            Window.default.rootViewController?.view.addSubview(self.view)
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
                    self.finish()
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
		
		override func cancel() {
            super.cancel();
            self.isCancelled = true;
            if self.isExecuting {
                self.finish()
                self.view.removeFromSuperview()
            }
		}
        
        func finish() {
            self.isExecuting = false
            self.isFinished  = true
        }
	}
	
	class Manager {
		
		private let queue: OperationQueue = {
			let queue = OperationQueue()
			queue.name = "org.diorstone.ToastCenter"
			queue.maxConcurrentOperationCount = 1
			return queue
		}()
        
        var currentOperation: Operation? {
            return self.queue.operations.first{ !$0.isCancelled && !$0.isFinished } as? Operation
        }
		
		static let `default` = Manager()
		
		init() { }
		
		func add(_ operation: Operation)  {
			self.queue.addOperation(operation)
		}
		
		func cancelAll() {
			self.queue.cancelAllOperations()
		}
	}
	
	class Window: UIKit.UIWindow {
		
		static let `default` = Window(frame: UIScreen.main.bounds)
		
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.isUserInteractionEnabled = false
            self.windowLevel = CGFloat.greatestFiniteMagnitude
            self.backgroundColor = .clear
            self.isHidden = false
			self.rootViewController = UIViewController()
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(statusBarOrientationDidChange),
                                                   name: .UIApplicationDidChangeStatusBarOrientation,
                                                   object: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func statusBarOrientationDidChange() {
            DispatchQueue.main.async {
                Manager.default.currentOperation?.view.setNeedsLayout()
            }
        }
    }
}
