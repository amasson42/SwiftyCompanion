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
            skills?.sort(by: {$0.name < $1.name})
            self.setNeedsDisplay(self.bounds)
        }
    }

    override func draw(_ rect: CGRect) {
        
        // MARK: - drawing constants
        let circleRadius = 0.60 * rect.width / 2
        let numberOfCircles = 4
        let circleLinesWidth: CGFloat = 0.5
        let textFont = UIFont(name: "Arial", size: self.frame.width * 0.025)!
        
        // MARK: - drawing circles
        UIColor.gray.setStroke()
        for i in 1 ... numberOfCircles {
            let fractCircleRadius = circleRadius * CGFloat(i) / CGFloat(numberOfCircles)
            let fractRect = CGRect(x: rect.origin.x + rect.width / 2 - fractCircleRadius,
                                   y: rect.origin.y + rect.height / 2 - fractCircleRadius,
                                   width: fractCircleRadius * 2,
                                   height: fractCircleRadius * 2)
            let circlePath = UIBezierPath(ovalIn: fractRect)
            circlePath.lineWidth = circleLinesWidth
            circlePath.stroke()
        }
        
        guard let skills = self.skills,
            !skills.isEmpty else {
            return
        }
        
        let alpha: CGFloat = .pi * 2 / CGFloat(skills.count)
        
        func circlePoint(forAlpha iAlpha: CGFloat, factor: CGFloat) -> CGPoint {
            return CGPoint(x: rect.midX + cos(iAlpha * alpha) * circleRadius * factor,
                           y: rect.midY + sin(iAlpha * alpha) * circleRadius * factor)
        }
        
        for i in 0 ..< skills.count {
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: rect.midX, y: rect.midY))
            linePath.addLine(to: circlePoint(forAlpha: CGFloat(i) , factor: 1.0))
            //  if the corrector is a retard, write "+ 0.5" here ⤴
            linePath.lineWidth = circleLinesWidth
            linePath.stroke()
        }
        
        let skillPath = UIBezierPath()
        skillPath.move(to: circlePoint(forAlpha: -1.0, factor: CGFloat(skills.last!.level / 20.0)))
        for i in 0 ..< skills.count {
            skillPath.addLine(to: circlePoint(forAlpha: CGFloat(i),
                                              factor: CGFloat(skills[i].level / 20.0)))
        }
        UIColor(red: 30.0 / 255.0, green: 186.0 / 255.0, blue: 187.0 / 255.0, alpha: 0.5).setStroke()
        skillPath.lineWidth = 2.0
        skillPath.stroke()
        UIColor(red: 86.0 / 255.0, green: 203.0 / 255.0, blue: 204.0 / 255.0, alpha: 0.5).setFill()
        skillPath.fill()
        
        func drawText(_ text: String, in rect: CGRect) {
            let attribText = NSAttributedString(string: text)
            attribText.size()
            attribText.draw(in: rect)
        }
        
        for i in 0 ..< skills.count {
            let targetPoint = circlePoint(forAlpha: CGFloat(i), factor: 1.3)
            
            let name = skills[i].name.replacingOccurrences(of: " ", with: "\n")
            var linesCount = 1
            name.forEach {
                if $0 == "\n" {
                    linesCount += 1
                }
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attributes: [NSAttributedStringKey: Any] = [
                NSAttributedStringKey.font: textFont,
                NSAttributedStringKey.paragraphStyle: paragraphStyle
            ]
            let attribText = NSAttributedString(string: name, attributes: attributes)
            let textSize = attribText.size()
            
            let targetRect: CGRect = CGRect(x: targetPoint.x - textSize.width / 2,
                                            y: targetPoint.y - textSize.height / 2,
                                            width: textSize.width, height: textSize.height)
            
            attribText.draw(in: targetRect)
        }
    }
}
