//
//  CrosshairOverlay.swift
//  debugdrawer
//
//  Created by Elias Bagley on 11/22/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation

let lineWidth:CGFloat = 1.0

class CrosshairOverlay : UIView {

    let horizontal : UIView = UIView()
    let vertical : UIView = UIView()
    let label = UILabel()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        horizontal = UIView()
        vertical = UIView()
        super.init(frame: frame)

        vertical.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.75)
        horizontal.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.75)
        label.backgroundColor = UIColor.redColor()

        horizontal.setTranslatesAutoresizingMaskIntoConstraints(false)
        vertical.setTranslatesAutoresizingMaskIntoConstraints(false)

        horizontal.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineWidth)
        vertical.frame = CGRectMake(0, 0, lineWidth, CGRectGetHeight(self.bounds))
        label.frame = CGRectMake(0, 0, 100, 30)

        self.addSubview(horizontal)
        self.addSubview(vertical)
        self.addSubview(label)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()
        if let point = touch?.locationInView(self) {
            self.setFramesFromPoint(point)
        }

        super.touchesBegan(touches, withEvent: event)
    }

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()
        if let point = touch?.locationInView(self) {
            self.setFramesFromPoint(point)
        }

        super.touchesMoved(touches, withEvent: event)
    }

    func setFramesFromPoint(point: CGPoint) {
        horizontal.frame = CGRectMake(0, point.y, CGRectGetWidth(self.bounds), lineWidth)
        vertical.frame = CGRectMake(point.x, 0, lineWidth, CGRectGetHeight(self.bounds))

        label.text = "\(point.x), \(point.y)"
    }
}
