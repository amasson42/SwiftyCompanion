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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletsLabel: UILabel!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    @IBOutlet weak var coalitionPointsLabel: UILabel!
    @IBOutlet weak var coalitionRankLabel: UILabel!
    @IBOutlet weak var logedPostLabel: UILabel!
    
    func takeValuesFromStudent(student: Any?) {
        self.profileImageView.image = #imageLiteral(resourceName: "empty")
        self.loginLabel.text = "amasson"
        self.mailLabel.text = "amasson@student.42.fr"
        self.phoneLabel.text = "phone: +33646882325"
        self.walletsLabel.text = "wallets: 12"
        self.correctionPointsLabel.text = "corrections points: 15"
        self.coalitionPointsLabel.text = "coalition: 104 points"
        self.coalitionRankLabel.text = "rank: 60"
        self.logedPostLabel.text = "Unavailable"
    }
}
