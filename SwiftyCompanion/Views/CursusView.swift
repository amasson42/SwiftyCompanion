//
//  CursusView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class CursusView: UIView {
    
    @IBOutlet weak var cursusSelector: UISegmentedControl!
    @IBOutlet weak var achievementsView: UICollectionView!
    @IBOutlet weak var expertiseView: UITableView!
    @IBOutlet weak var skillView: StudentSkillView!
    
    var student: Student? {
        didSet {
            if self.student != nil {
                self.reloadUI()
            }
        }
    }
    
    @IBAction func selectCursus(_ sender: UISegmentedControl) {
        guard let student = self.student else {
            return
        }
        self.skillView.skills = student.cursus[sender.selectedSegmentIndex].skillsArray
    }
    
    func reloadUI() {
        self.cursusSelector.removeAllSegments()
        if let student = self.student {
            for cursus in student.cursus {
                self.cursusSelector.insertSegment(withTitle: cursus.name, at: self.cursusSelector.numberOfSegments, animated: false)
            }
            self.cursusSelector.selectedSegmentIndex = 0
            self.selectCursus(self.cursusSelector)
        }
        
        self.achievementsView.reloadData()
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
        
        let imageView = viewCell.viewWithTag(1) as! WebImageView
        let nameView = viewCell.viewWithTag(2) as! UILabel
        
        imageView.imageUrl = "https://api.intra.42.fr" + student.achievements[indexPath.row].image
        imageView.reloadImage {
            if let error = imageView.downloadError {
                print("webview download error:", error)
            }
        }
        nameView.text = student.achievements[indexPath.row].name
        
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
