//
//  Application.swift
//
//  The MIT License (MIT)
//  Copyright © 2018 DiorStone

import UIKit

/// App相关信息
///
///[参考链接](https://github.com/FabrizioBrancati/BFKit-Swift/blob/2.4.1/Sources/BFKit/Linux/BFKit/BFApp.swift)
public class Application {

    /// App是否第一次启动(调用后变true)
    ///## 返回值:
    ///- **true**: 第一次
    ///- **false**: 不是
    ///
    ///## 使用场景:
    ///1. 添加引导页等
    public static let isFirstStart: Bool = {
        let key = UserDefaultsKey.isFirstStart.rawValue + Application.version + Application.build
        let value = !UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstStart.rawValue)
        if value {
            UserDefaults.standard.setValue(true, forKey: key)
            UserDefaults.standard.synchronize()
        }
        return value
    }()
    
    /// App是否DEBUG model(通过#if DEBUG判断)
    ///## 返回值:
    ///- **true**: debug mode
    ///- **false**:
    ///
    ///## 使用场景:
    ///1. 打印日志
    ///2. 隐藏功能等
    public static let isDebug: Bool = {
        var value = false
        #if DEBUG
            value = true
        #endif
        return value
    }()
}

// MARK: - Bundle infos
/// Bundle infos
public extension Application {
    
    /// name = **CFBundleDisplayName**
    public static let name: String = {
        let value = stringFromInfoDictionary(forKey: "CFBundleDisplayName")
        if value == "" {
            return stringFromInfoDictionary(forKey: "CFBundleName")
        } else {
            return value
        }
    }()
    
    /// bundleId = **CFBundleIdentifier**
    public static let bundleId: String = {
        return stringFromInfoDictionary(forKey: "CFBundleIdentifier")
    }()
    
    /// version = **CFBundleShortVersionString**
    public static let version: String = {
        return stringFromInfoDictionary(forKey: "CFBundleShortVersionString")
    }()
    
    /// build = **CFBundleVersion**
    public static let build: String = {
        return stringFromInfoDictionary(forKey: "CFBundleVersion")
    }()
    
    private static func stringFromInfoDictionary(forKey key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary, let value = infoDictionary[key] as? String else {
            return ""
        }
        return value
    }
}

extension Application {
    
    enum UserDefaultsKey: String {
        case isFirstStart = "DSFoundation_isFirstStart"
    }
}
