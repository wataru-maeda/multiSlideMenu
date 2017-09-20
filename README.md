# Multi Slide Menu

[![CI Status](http://img.shields.io/travis/WataruMaeda/multiSlideMenu.svg?style=flat)](https://travis-ci.org/WataruMaeda/multiSlideMenu)
[![Version](https://img.shields.io/cocoapods/v/multiSlideMenu.svg?style=flat)](http://cocoapods.org/pods/multiSlideMenu)
[![License](https://img.shields.io/cocoapods/l/multiSlideMenu.svg?style=flat)](http://cocoapods.org/pods/multiSlideMenu)
[![Platform](https://img.shields.io/cocoapods/p/multiSlideMenu.svg?style=flat)](http://cocoapods.org/pods/multiSlideMenu)

## Features

- [x] Top, Left, Bottom and Right side positioning
- [x] Easy to use, fully customisable, added slide menus without needing to write tons of code
- [x] Enable to toggle slide menu with a button action.
- [x] Keeps track of x, y point while dragging slide menu.
- [x] Supports continuous swiping between side menus on 4 sides in a single gesture.

## Demos

<img src="https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example1.gif" width="280">  <img src="https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example2.gif" width="280">  <img src="https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example3.gif" width="280">

## Installation

~~multiSlideMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:~~

```ruby
pod 'multiSlideMenu’, ‘~> 0.1.0’
```

*Add the [MultiSlideMenuViewController](https://github.com/WataruMaeda/multiSlideMenu/blob/master/multiSlideMenu/Classes/MultiSlideMenuViewController.swift) file to your project manually.

## Usage

 1. Inherit `MultiSlideMenuViewController` in your `UIViewController` class
 
```Swift
import UIKit

class ViewController: MultiSlideMenuViewController {
```

 2. Initialize `SlideMenuView` with position and bounds, That's all!
 
```Swift
// Sets up left slide menu
let sideMenu = SlideMenuView(position: .Left, bounds: view.frame)
sideMenu.backgroundColor = .yellow
super.setupSlideMenus(views: [sideMenu])
```

<img src="https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/sample.gif" width="100">
 
## Customize View

1. Create subview of `SlideMenuView` class

```Swift
import UIKit

class CustomSlideMenu: SlideMenuView {
```

2. You can add code for your custom UI

```Swift
import UIKit

class CustomSlideMenu: SlideMenuView {
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // your code here
    }
}
```
See the [Code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo1/demo1/CustomSlideMenu.swift) or [Sample](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example1.gif)

## Get position in `CustomSlideMenu`

Your can override functions that keeps track of x, y position while dragging

See the [Code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo1/demo2/CustomSlideMenu.swift#L76#L119) or [Sample](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example2.gif)

## Get position in `ViewController`

Your can override the functions `func getPresentingSlideWithPoint(slideMenu: point: )`
 
 See the [Code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/Demo3/Demo3/ViewController.swift#L65) or [Sample](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example3.gif)
 
## Requirements

iOS 8+  
Swift 3.0+  
Xcode 8.0+

## License

This project is available under the MIT license. See the [LICENSE](https://github.com/WataruMaeda/multiSlideMenu/blob/master/LICENSE) file for more info.
