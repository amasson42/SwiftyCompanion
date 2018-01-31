//
//  StudentProfileView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class StudentProfileView: UIView {
    
    static let coalitionsImages: [Int: UIImage?] = [
        1: UIImage(named: "federation_background"),
        2: UIImage(named: "alliance_background"),
        3: UIImage(named: "assembly_background"),
        4: UIImage(named: "order_background")
    ]
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletsLabel: UILabel!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    @IBOutlet weak var coalitionPointsLabel: UILabel!
    @IBOutlet weak var logedPostLabel: UILabel!
    
    func takeValuesFromStudent(student: Student) {
        if let coalition = student.coalition,
            let image = StudentProfileView.coalitionsImages[coalition.id] {
            self.backgroundImage.image = image
        }
        self.profileImageView.imageUrl = student.profile_image_url
        self.profileImageView.reloadImage()
        self.nameLabel.text = student.displayname
        self.mailLabel.text = "mail: \(student.email)"
        self.phoneLabel.text = "phone: \(student.phone)"
        self.walletsLabel.text = "wallets: \(student.wallet)"
        self.correctionPointsLabel.text = "corrections points: \(student.correction_points)"
        if let coalition = student.coalition {
            self.coalitionPointsLabel.text = "coalition: \(coalition.name) \(coalition.score) pts"
        } else {
            self.coalitionPointsLabel.text = ""
        }
        self.logedPostLabel.text = "\(student.location)"
    }
}
