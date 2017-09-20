//
//  MultiSlideMenuViewController.swift
//  multiSlideMenu
//
//  Created by Wataru Maeda on 2017/02/18.
//  Copyright © 2017 Wataru Maeda. All rights reserved.
//

import UIKit

typealias GetPoint = (_ point: CGPoint) -> ()
typealias GetSlideWithPoint = (_ slideMenu: SlideMenuView, _ point: CGPoint) -> ()

public enum SlideMenuViewPosition {
    case Top, Left, Bottom, Right
}

fileprivate enum SlideMenuDirectoin {
    case Up, Left, Down, Right
}

class MultiSlideMenuViewController: UIViewController {
    fileprivate var views = [SlideMenuView]()
    fileprivate var direction: SlideMenuDirectoin = .Up
    fileprivate var pointBeginning = CGPoint(x: 0, y: 0)
    fileprivate var isInAnimation = false
    
    fileprivate var centeredView: SlideMenuView?
    fileprivate var slideMenuViewTop: SlideMenuView?
    fileprivate var slideMenuViewLeft: SlideMenuView?
    fileprivate var slideMenuViewBottom: SlideMenuView?
    fileprivate var slideMenuViewRight: SlideMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: - Getter

extension MultiSlideMenuViewController {
    func getCenteredView() -> SlideMenuView? {
        return centeredView
    }
    
    func getSlideMenuTop() -> SlideMenuView? {
        return slideMenuViewTop
    }
    
    func getSlideMenuLeft() -> SlideMenuView? {
        return slideMenuViewLeft
    }
    
    func getSlideMenuBottom() -> SlideMenuView? {
        return slideMenuViewBottom
    }
    
    func getSlideMenuRight() -> SlideMenuView? {
        return slideMenuViewRight
    }
    
    func getSlideMenuAll() -> [SlideMenuView] {
        var slideMenus = [SlideMenuView]()
        if let top = slideMenuViewTop {
            slideMenus.append(top)
        }
        if let left = slideMenuViewLeft {
            slideMenus.append(left)
        }
        if let bottom = slideMenuViewBottom {
            slideMenus.append(bottom)
        }
        if let right = slideMenuViewRight {
            slideMenus.append(right)
        }
        return slideMenus
    }
    
    func getPresentingSlideWithPoint(slideMenu: SlideMenuView, point: CGPoint) {}
}

// MARK: - Setter

extension MultiSlideMenuViewController {
    func setupSlideMenus(views: [SlideMenuView]) {
        if views.count > 0 {
            self.views = views
            setViewsInDefaultPositions()
            setPanGesture()
            setPrecenceCallback()
        }
    }
    
    private func setPanGesture() {
        // Pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panTopView(gesture:)))
        view.addGestureRecognizer(panGesture)
    }
    
    private func setPrecenceCallback() {
        for v in views {
            v.showCallback = {
                self.setViewsInDefaultPositions()
                self.moveToCenter(v: v)
            }
            v.hideCallback = {
                self.direction = self.getDirectionFromPosition(position: v.position)
                self.backToOriginalPosition()
            }
            v.getSlideWithPoint = { (slideMenu, point) in
                self.getPresentingSlideWithPoint(slideMenu: slideMenu, point: point)
            }
        }
    }
    
    fileprivate func setViewsInDefaultPositions() {
        centeredView?.removeFromSuperview()
        centeredView = nil
        for v in views {
            // Set views to default position
            v.removeFromSuperview()
            setViewInDefaultPosition(v: v)
        }
    }
    
    fileprivate func setBeginningPoint() {
        if direction == .Up {
            if let v = slideMenuViewBottom {
                pointBeginning = v.frame.origin
                v.willShow(point: pointBeginning)
                v.startDragging(point: pointBeginning)
            }
        }
        else if direction == .Left {
            if let v = slideMenuViewRight {
                pointBeginning = v.frame.origin
                v.willShow(point: pointBeginning)
                v.startDragging(point: pointBeginning)
            }
        }
        else if direction == .Down {
            if let v = slideMenuViewTop {
                pointBeginning = v.frame.origin
                v.willShow(point: pointBeginning)
                v.startDragging(point: pointBeginning)
            }
        }
        else if direction == .Right {
            if let v = slideMenuViewLeft {
                pointBeginning = v.frame.origin
                v.willShow(point: pointBeginning)
                v.startDragging(point: pointBeginning)
            }
        }
    }
    
    private func setViewInDefaultPosition(v: SlideMenuView) {
        if v.position == .Top {
            slideMenuViewTop = v
            var frm = slideMenuViewTop!.frame
            frm.origin.x = view.frame.size.width / 2 - frm.size.width / 2
            frm.origin.y = -frm.size.height
            slideMenuViewTop?.frame = frm
            view.addSubview(slideMenuViewTop!)
        }
        else if v.position == .Left {
            slideMenuViewLeft = v
            var frm = slideMenuViewLeft!.frame
            frm.origin.x = -frm.size.width
            frm.origin.y = view.frame.size.height / 2 - frm.size.height / 2
            slideMenuViewLeft?.frame = frm
            view.addSubview(slideMenuViewLeft!)
        }
        else if v.position == .Bottom {
            slideMenuViewBottom = v
            var frm = slideMenuViewBottom!.frame
            frm.origin.x = view.frame.size.width / 2 - frm.size.width / 2
            frm.origin.y = view.frame.size.height
            slideMenuViewBottom?.frame = frm
            view.addSubview(slideMenuViewBottom!)
        }
        else {
            slideMenuViewRight = v
            var frm = slideMenuViewRight!.frame
            frm.origin.x = view.frame.size.width
            frm.origin.y = view.frame.size.height / 2 - frm.size.height / 2
            slideMenuViewRight?.frame = frm
            view.addSubview(slideMenuViewRight!)
        }
    }
}

// MARK: - Gesture

extension MultiSlideMenuViewController {
    func panTopView(gesture: UIPanGestureRecognizer) {
        // Return if in the middle of animation
        if isInAnimation { return }
        
        // Get tapped location
        let location = gesture.translation(in: view)
        
        if gesture.state == .began {
            // If a view is center
            if let v = centeredView {
                pointBeginning = v.frame.origin
            }
            else {
                // Get drag direction
                direction = getDirectionFromGesture(gesture: gesture)
                
                // Set Beginning point
                setBeginningPoint()
                
                // Setback to default position
                setViewsInDefaultPositions()
            }
        }
        else if gesture.state == .changed {
            // If a view is center
            if centeredView != nil {
                // Drag centered view
                dragCenteredView(distance: location)
            }
            else {
                // Drag view
                dragView(distance: location)
            }
        }
        else if gesture.state == .ended {
            // If a view is center
            if centeredView != nil {
                // Controll a centerd veiw position after gesture ended
                controllCenteredViewPositioningDependsOnLocation(location: location)
            }
            else {
                // Controll position after gesture ended
                controllPositioningDependsOnLocation(location: location)
            }
        }
    }
    
    private func controllCenteredViewPositioningDependsOnLocation(location: CGPoint) {
        if let v = centeredView {
            if v.position == .Top {
                if pointBeginning.y + location.y + v.frame.size.height < v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
            }
            else if v.position == .Bottom {
                if pointBeginning.y + location.y < v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
            }
            else if v.position == .Left {
                if pointBeginning.x + location.x > -v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
            }
            else if v.position == .Right {
                if pointBeginning.x + location.x < v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
            }
        }
    }
    
    private func controllPositioningDependsOnLocation(location: CGPoint) {
        if direction == .Up {
            if let v = slideMenuViewBottom {
                if pointBeginning.y + location.y > v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
                v.endDragging(point: v.frame.origin)
            }
        }
        else if direction == .Left {
            if let v = slideMenuViewRight {
                if pointBeginning.x + location.x > -v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
                v.endDragging(point: v.frame.origin)
            }
        }
        else if direction == .Down {
            if let v = slideMenuViewTop {
                if pointBeginning.y + location.y + v.frame.size.height > v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
                v.endDragging(point: v.frame.origin)
            }
        }
        else {
            if let v = slideMenuViewLeft {
                if pointBeginning.x + location.x + v.frame.size.width > v.presentingPoint {
                    moveToCenter(v: v)
                } else {
                    backToOriginalPosition()
                }
                v.endDragging(point: v.frame.origin)
            }
        }
    }
    
    private func dragCenteredView(distance: CGPoint) {
        if let v = centeredView {
            if v.position == .Top {
                var y = pointBeginning.y + distance.y
                if y > v.bounceBackPoint { return }
                var frm = v.frame
                frm.origin.y = y
                if y > 0 { y = 0 }
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
            else if v.position == .Bottom {
                var y = pointBeginning.y + distance.y
                if y < -v.bounceBackPoint {
                    return moveToCenter(v: v)
                }
                var frm = v.frame
                frm.origin.y = y
                if y < view.frame.size.height { y = view.frame.size.height }
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
            else if v.position == .Left {
                let x = pointBeginning.x + distance.x
                if x > v.bounceBackPoint {
                    return moveToCenter(v: v)
                }
                var frm = v.frame
                frm.origin.x = x
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
            else if v.position == .Right {
                var x = pointBeginning.x + distance.x
                if x < -v.bounceBackPoint {
                    return moveToCenter(v: v)
                }
                var frm = v.frame
                frm.origin.x = x
                if x < view.frame.size.width { x = view.frame.size.width }
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
        }
    }
    
    private func dragView(distance: CGPoint) {
        if direction == .Up {
            if let v = slideMenuViewBottom {
                var frm = v.frame
                frm.origin.y = pointBeginning.y + distance.y
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
        }
        else if direction == .Left {
            if let v = slideMenuViewRight {
                var frm = v.frame
                frm.origin.x = pointBeginning.x + distance.x
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
        }
        else if direction == .Down {
            if let v = slideMenuViewTop {
                var frm = v.frame
                frm.origin.y = pointBeginning.y + distance.y
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
        }
        else {
            if let v = slideMenuViewLeft {
                var frm = v.frame
                frm.origin.x = pointBeginning.x + distance.x
                v.frame = frm
                v.continueDragging(point: frm.origin)
            }
        }
    }
    
    fileprivate func moveToCenter(v: SlideMenuView) {
        if isInAnimation { return }
        isInAnimation = true
        UIView.animate(withDuration: 0.3, animations: {
            v.center = self.view.center
        }, completion: { finished in
            v.centered = true
            v.endDragging(point: self.view.frame.origin)
            v.didShow(point: self.view.frame.origin)
            self.centeredView = v
            self.isInAnimation = false
        })
    }
    
    func backToOriginalPosition() {
        if direction == .Up {
            if let v = slideMenuViewBottom {
                var origin = v.frame.origin
                origin.x = view.frame.size.width / 2 - v.frame.size.width / 2
                origin.y = v.frame.size.height
                isInAnimation = true
                v.willDisappear(point: origin)
                UIView.animate(withDuration: 0.3, animations: {
                    v.frame.origin = origin
                }, completion: { (finished) in
                    v.centered = false
                    v.didDisappear(point: origin)
                    self.isInAnimation = false
                    self.setViewsInDefaultPositions()
                })
            }
        }
        else if direction == .Left {
            if let v = slideMenuViewRight {
                var origin = v.frame.origin
                origin.x = view.frame.size.width
                origin.y = view.frame.size.height / 2 - v.frame.size.height / 2
                isInAnimation = true
                v.willDisappear(point: origin)
                UIView.animate(withDuration: 0.3, animations: {
                    v.frame.origin = origin
                }, completion: { (finished) in
                    v.centered = false
                    v.didDisappear(point: origin)
                    self.isInAnimation = false
                    self.setViewsInDefaultPositions()
                })
            }
        }
        else if direction == .Down {
            if let v = slideMenuViewTop {
                var origin = v.frame.origin
                origin.x = view.frame.size.width / 2 - v.frame.size.width / 2
                origin.y = -v.frame.size.height
                isInAnimation = true
                v.willDisappear(point: origin)
                UIView.animate(withDuration: 0.3, animations: {
                    v.frame.origin = origin
                }, completion: { (finished) in
                    v.centered = false
                    v.didDisappear(point: origin)
                    self.isInAnimation = false
                    self.setViewsInDefaultPositions()
                })
            }
        }
        else {
            if let v = slideMenuViewLeft {
                var origin = v.frame.origin
                origin.x = -v.frame.size.width
                origin.y = view.frame.size.height / 2 - v.frame.size.height / 2
                isInAnimation = true
                v.willDisappear(point: origin)
                UIView.animate(withDuration: 0.3, animations: {
                    v.frame.origin = origin
                }, completion: { (finished) in
                    v.centered = false
                    v.didDisappear(point: origin)
                    self.isInAnimation = false
                    self.setViewsInDefaultPositions()
                })
            }
        }
    }
}

// MARK: - SlideMenuView (Init)

class SlideMenuView: UIView {
    fileprivate var showCallback: ()->() = {_ in}
    fileprivate var hideCallback: ()->() = {_ in}
    fileprivate var getSlideWithPoint: GetSlideWithPoint = {_ in}
    fileprivate var position: SlideMenuViewPosition = .Top
    fileprivate var centered = false
    
    // Showing SideMenu if the user dragged 50px from original point is default
    var presentingPoint = 50 as CGFloat
    var bounceBackPoint = 100 as CGFloat
    var keepTrackCurrentPoint: GetPoint = {_ in}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(position: SlideMenuViewPosition, bounds: CGRect) {
        super.init(frame: bounds)
        self.position = position
        backgroundColor = .white
    }
    
    func getPosition() -> SlideMenuViewPosition {
        return position
    }
}

// MARK: - SlideMenuView (Display)

extension SlideMenuView {
    func isCentered() -> Bool {
        return centered
    }
    
    func show() {
        showCallback()
    }
    
    func hide() {
        hideCallback()
    }
}

// MARK: - SlideMenuView (Tracking position)

extension SlideMenuView {
    func willShow(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func didShow(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func willDisappear(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func didDisappear(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func startDragging(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func continueDragging(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
    
    func endDragging(point: CGPoint) {
        keepTrackCurrentPoint(point)
        getSlideWithPoint(self, point)
    }
}

// MARK: - Supporting functions

extension MultiSlideMenuViewController {
    fileprivate func getDirectionFromGesture(gesture: UIPanGestureRecognizer) -> SlideMenuDirectoin {
        let velocity = gesture.velocity(in: view)
        let isVerticalGesture: Bool = fabs(velocity.y) > fabs(velocity.x)
        if isVerticalGesture {
            if velocity.y > 0 {
                return .Down
            } else {
                return .Up
            }
        }
        else {
            if velocity.x > 0 {
                return .Right
            } else {
                return .Left
            }
        }
    }
    
    fileprivate func getDirectionFromPosition(position: SlideMenuViewPosition) -> SlideMenuDirectoin {
        if position == .Top { return .Down }
        if position == .Left { return .Right }
        if position == .Bottom { return .Up }
        return .Left
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
