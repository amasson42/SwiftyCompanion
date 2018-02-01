//
//  StudentSkillView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/31/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class StudentSkillView: UIView {
    
    var skills: [Skill]? = nil {
        didSet {
            self.setNeedsDisplay(self.bounds)
        }
    }

    override func draw(_ rect: CGRect) {
        let colors: [UIColor] = [.green, .red, .blue]
        colors[Int(arc4random() % 3)].set()
        UIBezierPath(rect: rect).fill()
    }
}
