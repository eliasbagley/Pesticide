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
    var root: UIView

    init(rootView: UIView) {
        root = rootView
        self.recurseThroughSubviews(rootView)
    }

    func recurseThroughSubviews(rootView: UIView) {
        // save default values
        rootView.saveDefaults()

        rootView.layer.borderWidth = 2.0
//        rootView.layer.borderColor = UIColor.redColor().CGColor
        rootView.userInteractionEnabled = true


        self.addDeleteBlock(rootView)

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
            view.alpha = 0
            view.userInteractionEnabled = false
        }
    }

    @objc func undo() {
        if (removedViews.count > 0) {
            let last = removedViews.removeLast()
            last.restoreDefaults()
            last.userInteractionEnabled = true
        }
    }

    func undoAll() {
        while (removedViews.count > 0) {
            undo()
        }
    }

    // call this to return view hierarchy to original
    func done() {
        done(root)
    }

    func done(rootView: UIView) {
        rootView.restoreDefaults()

        for subview in rootView.subviews {
            done(subview as UIView)
        }
    }
    
}