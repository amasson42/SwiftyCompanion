//
//  StudentProfileView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class StudentProfileView: UIView {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletsLabel: UILabel!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    @IBOutlet weak var coalitionPointsLabel: UILabel!
    @IBOutlet weak var coalitionRankLabel: UILabel!
    @IBOutlet weak var logedPostLabel: UILabel!
    
    func takeValuesFromStudent(student: Student) {
        self.profileImageView.imageUrl = student.profile_image_url
        self.profileImageView.reloadImage()
        self.nameLabel.text = student.displayname
        self.mailLabel.text = "mail: \(student.email)"
        self.phoneLabel.text = "phone: \(student.phone)"
        print(student.wallet)
        self.walletsLabel.text = "wallets: \(student.wallet)"
        self.correctionPointsLabel.text = "corrections points: \(student.correction_points)"
        self.coalitionPointsLabel.text = "coalition: 104 points"
        self.coalitionRankLabel.text = "rank: 60"
        self.logedPostLabel.text = "\(student.location)"
    }
}
