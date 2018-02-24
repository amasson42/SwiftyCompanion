//
//  CursusView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit
import SwiftSVG

class CursusView: UIView {
    
    @IBOutlet weak var cursusSelector: UISegmentedControl!
    @IBOutlet weak var achievementsView: UICollectionView!
    @IBOutlet weak var expertiseView: UITableView!
    @IBOutlet weak var seeProjectsButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressLevelBar: UIProgressView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var skillView: StudentSkillView!
    @IBOutlet weak var skillViewWidthLayout: NSLayoutConstraint!
    @IBOutlet weak var skillBlurView: UIVisualEffectView!
    var skillViewOpen: Bool = false
    
    var achievementsImages: [Int: UIImage] = [:]
    
    var student: Student? {
        didSet {
            if self.student != nil {
                self.reloadUI()
            }
        }
    }
    
    func setCursus(_ index: Int) {
        guard let student = self.student,
            student.cursus.indices.contains(index) else {
                self.seeProjectsButton.isEnabled = false
                return
        }
        self.seeProjectsButton.isEnabled = true
        self.levelLabel.text = "Level \(Int(student.cursus[index].level.integerPart))"
        self.progressLevelBar.progress = Float(student.cursus[index].level.decimalPart)
        self.skillView.skills = student.cursus[index].skillsArray
    }
    
    func reloadUI() {
        
        self.cursusSelector.removeAllSegments()
        if let student = self.student {
            for cursus in student.cursus {
                self.cursusSelector.insertSegment(withTitle: cursus.name, at: self.cursusSelector.numberOfSegments, animated: false)
            }
            self.cursusSelector.selectedSegmentIndex = 0
            self.setCursus(self.cursusSelector.selectedSegmentIndex)
        }
        
        self.achievementsView.layer.borderWidth = 1.0
        self.achievementsView.layer.borderColor = UIColor.black.cgColor
        self.achievementsView.reloadData()
        
        self.expertiseView.layer.borderWidth = 0.5
        self.expertiseView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func tapSkills(_ sender: UITapGestureRecognizer) {
        self.skillViewOpen = !self.skillViewOpen
        
        UIView.animate(withDuration: 0.75,
                       delay: 0.2,
                       usingSpringWithDamping: 5.0,
                       initialSpringVelocity: 3.0,
                       options: .curveEaseOut,
                       animations: {
                        if self.skillViewOpen {
                            self.skillViewWidthLayout.constant = self.frame.width * 0.45
                            self.skillLabel.layer.borderWidth = 1.0
                            self.skillLabel.layer.borderColor = UIColor.black.cgColor
                            self.skillLabel.layer.cornerRadius = 5.0
                            self.skillLabel.layer.masksToBounds = true
                            self.skillView.setNeedsDisplay()
                            self.skillBlurView.alpha = 0.8
                        } else {
                            self.skillViewWidthLayout.constant = 0
                            self.skillLabel.layer.borderWidth = 0.0
                            self.skillLabel.layer.cornerRadius = 0.0
                            self.skillBlurView.alpha = 0.0
                        }
                        self.layoutIfNeeded()
        })
    }
    
}

extension CursusView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.student?.achievements.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCell", for: indexPath)
        guard let student = self.student else {
            return viewCell
        }
        
        let imageView = viewCell.viewWithTag(1) as! UIImageView
        let nameLabel = viewCell.viewWithTag(2) as! UILabel

        let achievement = student.achievements[indexPath.row]
        if let image = self.achievementsImages[achievement.id] {
            imageView.image = image
        } else {
            let imageUrl = URL(string: "https://api.intra.42.fr" + achievement.image)!
            let svgImage = UIView(SVGURL: imageUrl, completion: {
                (layer) in
                let imageSize = CGSize(width: 50, height: 50)
                
                UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
                defer { UIGraphicsEndImageContext() }
                if let context = UIGraphicsGetCurrentContext() {
                    layer.render(in: context)
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    self.achievementsImages[achievement.id] = image
                    collectionView.reloadItems(at: [indexPath])
                }
            })
        }
        
        nameLabel.text = achievement.name
        
        return viewCell
    }
    
}

extension CursusView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.student?.expertises.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpertiseCell", for: indexPath)
        guard let student = self.student else {
            return cell
        }
        let expertise = student.expertises[indexPath.row]
        
        cell.textLabel?.text = ""
        
        var starsStr = String.init(repeating: "⭒", count: 5 - expertise.value)
        starsStr += String.init(repeating: "⭑", count: expertise.value)
        cell.detailTextLabel?.text = starsStr
        
        if let name = expertise.name {
            cell.textLabel?.text = name
        } else {
            expertise.loadName {
                DispatchQueue.main.async {
                    self.expertiseView?.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
        return cell
    }
    
}
