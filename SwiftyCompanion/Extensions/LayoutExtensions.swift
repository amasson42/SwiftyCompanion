//
//  LayoutExtensions.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 2/1/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func set(multiplier: CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(item: self.firstItem as Any,
                                               attribute: self.firstAttribute,
                                               relatedBy: self.relation,
                                               toItem: self.secondItem,
                                               attribute: self.secondAttribute,
                                               multiplier: multiplier,
                                               constant: self.constant)
        
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([self])
        return newConstraint
    }
    
}
