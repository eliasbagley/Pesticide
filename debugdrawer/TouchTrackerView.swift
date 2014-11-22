//
//  CrosshairOverlay.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/22/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

let radius:CGFloat = 15

class TouchTrackerView : UIView {

    let circle : UIView = UIView()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        circle = UIView()
        super.init(frame: frame)

        circle.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        circle.layer.cornerRadius = radius/2
        circle.layer.borderColor = UIColor.grayColor().CGColor
        circle.layer.borderWidth = 1
        circle.alpha = 0

        circle.setTranslatesAutoresizingMaskIntoConstraints(false)

        circle.frame = CGRectMake(0, 0, radius, radius)

        self.addSubview(circle)
    }

    // pass touches though this overlay view
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        self.setFramesFromPoint(point)
        showCircle()
        hideCircle()
        return false
    }

    func setFramesFromPoint(point: CGPoint) {
        circle.frame = CGRectMake(point.x, point.y, radius, radius)
    }

    func showCircle() {
        self.circle.alpha = 1;
    }

    func hideCircle() {
        UIView.animateWithDuration(0.15, delay: 0.1, options: .CurveEaseIn, animations: { () -> Void in
            self.circle.alpha = 0
        }, completion: nil)
    }
}
