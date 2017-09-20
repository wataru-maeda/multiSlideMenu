//
//  ViewController.swift
//  demo2
//
//  Created by Wataru Maeda on 2017/09/17.
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
            height: view.frame.size.height / 2)
        demoLabel.text = "Swipe to show the slide menu\n🙂"
        view.addSubview(demoLabel)
        
        var y = demoLabel.frame.maxY
        let positions: [SlideMenuViewPosition] = [.Top, .Left, .Bottom, .Right]
        let colors = [
            UIColor(red:0.906, green:0.278, blue:0.314, alpha:1.000),
            UIColor(red:0.200, green:0.624, blue:0.694, alpha:1.000),
            UIColor(red:0.231, green:0.671, blue:0.937, alpha:1.000),
            UIColor(red:0.365, green:0.204, blue:0.471, alpha:1.000)
        ]
        
        // Setup SlideMenus and show button
        for i in 0..<positions.count {
            let position = positions[i]
            
            // Create show button
            let button = getShowButton(position: position)
            button.center = CGPoint(
                x: view.frame.size.width / 2,
                y: y + button.frame.size.height / 2
            )
            button.tag = i
            button.addTarget(self, action: #selector(self.showMenu(_:)), for: .touchUpInside)
            view.addSubview(button)
            
            // Sets slide menu
            let slideMenu = CustomSlideMenu(position: position, bounds: .zero)
            slideMenu.backgroundColor = colors[i]
            slideMenu.frame = view.bounds
            slideMenus.append(slideMenu)
            
            y = button.frame.maxY + 20
        }
        
        // Sets side menus
        super.setupSlideMenus(views: slideMenus)
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
    func getShowButton(position: SlideMenuViewPosition) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle(
            getShowButtonTitle(position: position),
            for: .normal
        )
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.sizeToFit()
        return button
    }
    
    func getShowButtonTitle(position: SlideMenuViewPosition) -> String {
        switch position {
        case .Top:
            return "  Show Top  "
        case .Left:
            return "  Show Left  "
        case .Bottom:
            return "  Show Bottom  "
        case .Right:
            return "  Show Right  "
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
