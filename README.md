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

*Add the [MultiSlideMenuViewController.swift](https://github.com/WataruMaeda/multiSlideMenu/blob/master/multiSlideMenu/Classes/MultiSlideMenuViewController.swift) class to your project manually(drag & drap the class into your project).

## Usage

 1. Inherit `MultiSlideMenuViewController` in your `UIViewController` class
 
```Swift
class ViewController: MultiSlideMenuViewController {
```

 2. Initialize `SlideMenuView` with position and bounds, That's all!
 
```Swift
// Sets up left slide menu
let sideMenu = SlideMenuView(position: .Left, bounds: view.frame)
sideMenu.backgroundColor = .yellow
super.setupSlideMenus(views: [sideMenu])
```

It's specifing the slide menu is `Left` position, the view size is `view.frame` and background color is `yellow`.
<img src="https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/sample.gif" width="100">
 
## Customize View

It's fully customisable!

1. Create subview of `SlideMenuView` class  
2. You can add code in the `override func draw(_ rect: CGRect)` for your custom UI

```Swift
import UIKit

class CustomSlideMenu: SlideMenuView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // your code here for the custom UI...
    }
}
```
See the [code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo1/demo1/CustomSlideMenu.swift#L36L66) or [sample gif](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example1.gif) for more info.

## Toggle the slide view

You can call `show()` or `hide()` for toggle the views.  
For the `hide()` function, please check [here](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo2/demo2/CustomSlideMenu.swift#L71)
or the `show()`, you can check from [here](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo2/demo2/ViewController.swift#L82) 
You can see the [sample gif](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example2.gif).

## Get position in `CustomSlideMenu`

Tracking the current position is also important if you like to implement specific action in the specific timing.
There are some override functions to recognize the events.
* `func willShow(point: CGPoint)`
* `func didShow(point: CGPoint)`
* `func willDisappear(point: CGPoint)`
* `func didDisappear(point: CGPoint)`
* `func startDragging(point: CGPoint)`
* `func continueDragging(point: CGPoint)`
* `func endDragging(point: CGPoint)`

Your can override there functions that keeps track of x, y position while dragging  
See the [code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/demo2/demo2/CustomSlideMenu.swift#L76#L119) or [sample gif](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example2.gif) for more info.

## Get position in `ViewController`

Your can override the functions `func getPresentingSlideWithPoint(slideMenu: point: )`  
See the [code](https://github.com/WataruMaeda/multiSlideMenu/blob/master/demos/Demo3/Demo3/ViewController.swift#L65) or [sample gif](https://github.com/WataruMaeda/multiSlideMenu/blob/master/gifs/example3.gif) for more info.
 
## Requirements

iOS 8+  
Swift 3.0+  
Xcode 8.0+

## License

This project is available under the MIT license. See the [LICENSE](https://github.com/WataruMaeda/multiSlideMenu/blob/master/LICENSE) file for more info.
