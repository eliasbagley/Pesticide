//
//  UIView+Pesticide.swift
//  TestViewHierarchy
//
//  Created by Elias Bagley on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func allSubviewsInvisble() -> Bool {
        if (self.subviews.count == 0) {
            return true
        }

        for subview in self.subviews {
            if (subview as UIView).hidden == false {
                return false
            }
        }

        return true
    }

    func deepCopy() -> UIView {
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as UIView
    }
}
