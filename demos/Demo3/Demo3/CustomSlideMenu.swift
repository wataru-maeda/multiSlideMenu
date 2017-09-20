//
//  CustomSlideMenu.swift
//  demo1
//
//  Created by Wataru Maeda on 2017/09/16.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

class CustomSlideMenu: SlideMenuView {
    
    var emojiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60)
        label.numberOfLines = 0
        return label
    }()
    
    var hideButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitle("  Hide Menu  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.sizeToFit()
        return button
    }()
    
    override init(position: SlideMenuViewPosition, bounds: CGRect) {
        super.init(position: position, bounds: bounds)
        addSubview(emojiLabel)
        addSubview(hideButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        emojiLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: frame.size.width,
            height: frame.size.height / 3 * 2)
        emojiLabel.text = "Hello!"
        
        hideButton.center = CGPoint(
            x: frame.size.width / 2,
            y: emojiLabel.frame.maxY + frame.size.height / 8
        )
        hideButton.addTarget(
            self,
            action: #selector(self.hideMenu),
            for: .touchUpInside
        )
    }
}

// MARK: - Action

extension CustomSlideMenu {
    func hideMenu() {
        hide()
    }
}
