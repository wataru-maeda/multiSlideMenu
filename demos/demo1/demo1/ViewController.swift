//
//  ViewController.swift
//  demo1
//
//  Created by Wataru Maeda on 2017/09/15.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class ViewController: MultiSlideMenuViewController {
    
    var sideMenu: CustomSlideMenu = {
        let menu = CustomSlideMenu(position: .Left, bounds: .zero)
        return menu
    }()
    
    var demoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()
    
    var showButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle("  Show Menu  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.sizeToFit()
        return button
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
            height: view.frame.size.height / 3 * 2)
        demoLabel.text = "Swipe Right\nto show the left menu\n🙂"
        view.addSubview(demoLabel)
        
        // Button
        showButton.center = CGPoint(
            x: view.frame.size.width / 2,
            y: demoLabel.frame.maxY + view.frame.size.height / 8
        )
        showButton.addTarget(
            self,
            action: #selector(self.showMenu),
            for: .touchUpInside
        )
        view.addSubview(showButton)
        
        // Sets side menus
        sideMenu.frame = view.bounds
        super.setupSlideMenus(views: [sideMenu])
    }
}

// MARK: - Action

extension ViewController {
    func showMenu() {
        sideMenu.show()
    }
}

// MARK: - Supporting functions

extension ViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
