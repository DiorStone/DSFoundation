# DSFoundation
[![Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://swift.org)
[![Build Status](https://www.travis-ci.org/DiorStone/DSFoundation.svg?branch=master)](https://www.travis-ci.org/DiorStone/DSFoundation)
[![Version](https://img.shields.io/cocoapods/v/DSFoundation.svg?style=flat)](http://cocoapods.org/pods/DSFoundation)
[![Carthage](https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/DSFoundation.svg?style=flat)](http://cocoapods.org/pods/DSFoundation)
[![Platform](https://img.shields.io/cocoapods/p/DSFoundation.svg?style=flat)](http://cocoapods.org/pods/DSFoundation)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS8.0+
* xcode9+

##安装

### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build DSFoundation 0.1.0+.

To integrate DSFoundation into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'DSFoundation'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate DSFoundation into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "DiorStone/DSFoundation" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `DSFoundation.framework` into your Xcode project.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate Alamofire into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add DSPopup as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/DiorStone/DSFoundation.git
  ```

## 更新说明
* 0.1.0
  - 初始化版本提交

## 推荐依赖库
* [SwiftDate](https://github.com/malcommac/SwiftDate)常用日期处理
* [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)常用加密算法
* [Kingfisher](https://github.com/onevcat/Kingfisher)图片下载框架
* [Alamofire](https://github.com/Alamofire/Alamofire)网络框架
* [Defaults](https://github.com/sindresorhus/Defaults)UserDefaults存储app配置信息


## Author
mrdaios, mrdaios@gmail.com

## License
DSFoundation is available under the MIT license. See the LICENSE file for more info.
