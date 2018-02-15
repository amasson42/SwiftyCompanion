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
    
    static let coalitionsColors: [Int: UIColor] = [
        1: UIColor(red: 68.0 / 255.0, green: 130.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0),
        2: UIColor(red: 60.0 / 255.0, green: 195.0 / 255.0, blue: 129.0 / 255.0, alpha: 1.0),
        3: UIColor(red: 159.0 / 256.0, green: 100.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0),
        4: UIColor(red: 253.0 / 255.0, green: 105.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
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
    @IBOutlet weak var callButton: UIButton!
    
    func takeValuesFromStudent(student: Student) {
        
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height + profileImageView.frame.width
        self.profileImageView.layer.borderWidth = 1.0
        UIView.animate(withDuration: 0.75,
                       delay: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        self.profileImageView.layer.cornerRadius = 30.0
        }, completion: nil)
        if let coalition = student.coalition,
            let image = StudentProfileView.coalitionsImages[coalition.id] {
            self.backgroundImage.image = image
            self.profileImageView.layer.borderColor = StudentProfileView.coalitionsColors[coalition.id]?.cgColor
        } else {
            self.profileImageView.layer.borderColor = UIColor.black.cgColor
        }
        
        self.profileImageView.imageUrl = student.profile_image_url
        self.profileImageView.reloadImage()
        self.nameLabel.text = student.displayname
        self.mailLabel.text = "mail: \(student.email)"
        self.callButton.isHidden = student.phone.isEmpty || student.phone == "Unavailable"
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
