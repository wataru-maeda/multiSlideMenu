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
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()
    
    var hideButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor(red:0.906, green:0.278, blue:0.314, alpha:1.000)
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
        backgroundColor = UIColor(red:0.906, green:0.278, blue:0.314, alpha:1.000)
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

// MARK: - Override Methods

extension CustomSlideMenu {
    override func willShow(point: CGPoint) {
        super.willShow(point: point)
        emojiLabel.text = "Will show\n😎" + "\n\(point)"
        print("Will show")
    }
    
    override func didShow(point: CGPoint) {
        super.didShow(point: point)
        emojiLabel.text = "Did show\n🤗" + "\n\(point)"
        print("Did show")
    }
    
    override func willDisappear(point: CGPoint) {
        super.willDisappear(point: point)
        emojiLabel.text = "Will disappear\n😲" + "\n\(point)"
        print("Will disappear")
    }
    
    override func didDisappear(point: CGPoint) {
        super.didDisappear(point: point)
        emojiLabel.text = "Did disappear\n😭" + "\n\(point)"
        print("Did disappear")
    }
    
    override func startDragging(point: CGPoint) {
        super.startDragging(point: point)
        emojiLabel.text = "Start dragging\n🙂" + "\n\(point)"
        print("Start dragging")
    }
    
    override func continueDragging(point: CGPoint) {
        super.continueDragging(point: point)
        emojiLabel.text = "Continue dragging\n😬" + "\n\(point)"
        print("Continue dragging")
    }
    
    override func endDragging(point: CGPoint) {
        super.endDragging(point: point)
        emojiLabel.text = "End dragging\n😉" + "\n\(point)"
        print("End dragging")
    }
}
