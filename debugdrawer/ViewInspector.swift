//
//  ViewInspector.swift
//  TestViewHierarchy
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation
import UIKit

class ViewInspector {
    private var removedViews: [UIView] = []

    init(rootView: UIView) {
        self.recurseThroughSubviews(rootView);
    }

    func recurseThroughSubviews(rootView: UIView) {
        self.addDeleteBlock(rootView)
        rootView.layer.borderWidth = 2.0
        rootView.layer.borderColor = UIColor.redColor().CGColor

        for subview in rootView.subviews {
            self.recurseThroughSubviews(subview as UIView)
        }
    }

    func addDeleteBlock(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        let view = tapGesture.view!
        if (view.allSubviewsInvisble()) {
            self.removedViews.append(view)
            view.hidden = true
        }
    }

    @objc func undo() {
        if (removedViews.count > 0) {
            let last = removedViews.removeLast()
            last.hidden = false
        }
    }

    func undoAll() {
        while (removedViews.count > 0) {
            undo()
        }
    }
    
}