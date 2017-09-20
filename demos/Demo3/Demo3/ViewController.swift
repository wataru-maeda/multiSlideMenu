//
//  ViewController.swift
//  demo3
//
//  Created by Wataru Maeda on 2017/09/20.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class ViewController: MultiSlideMenuViewController {
  
  var slideMenus = [SlideMenuView]()
  
  var demoLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 40)
    label.numberOfLines = 0
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    view.backgroundColor = .darkGray
    
    // Label
    demoLabel.frame = CGRect(
      x: 0,
      y: 0,
      width: view.frame.size.width,
      height: view.frame.size.height)
    demoLabel.text = "Hidden\n🙂"
    view.addSubview(demoLabel)
    
    let positions: [SlideMenuViewPosition] = [.Top, .Left, .Bottom, .Right]
    let colors = [
      UIColor(red:0.906, green:0.278, blue:0.314, alpha:1.000),
      UIColor(red:0.200, green:0.624, blue:0.694, alpha:1.000),
      UIColor(red:0.231, green:0.671, blue:0.937, alpha:1.000),
      UIColor(red:0.365, green:0.204, blue:0.471, alpha:1.000)
    ]
    
    // Setup SlideMenus and show button
    for i in 0..<positions.count {
      let slideMenu = CustomSlideMenu(position: positions[i], bounds: .zero)
      slideMenu.backgroundColor = colors[i]
      slideMenu.frame = view.bounds
      slideMenus.append(slideMenu)
    }
    
    // Sets side menus
    super.setupSlideMenus(views: slideMenus)
  }
}

// MARK: - Override Methods

extension ViewController {
  override func getPresentingSlideWithPoint(slideMenu: SlideMenuView, point: CGPoint) {
    super.getPresentingSlideWithPoint(slideMenu: slideMenu, point: point)
    if slideMenu.getPosition() == .Top {
      demoLabel.text = "Upper😛\n\(point)"
    }
    else if slideMenu.getPosition() == .Left {
      demoLabel.text = "Left😜\n\(point)"
    }
    else if slideMenu.getPosition() == .Bottom {
      demoLabel.text = "Bottom😇\n\(point)"
    }
    else if slideMenu.getPosition() == .Right {
      demoLabel.text = "Right🤓\n\(point)"
    }
    
  }
}

// MARK: - Action

extension ViewController {
  func showMenu(_ sender: UIButton) {
    slideMenus[sender.tag].show()
  }
}

// MARK: - Supporting functions

extension ViewController {
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
