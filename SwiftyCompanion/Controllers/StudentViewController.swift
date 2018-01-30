//
//  StudentViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet weak var navigationHeader: UINavigationItem!
    @IBOutlet weak var headerProfileView: StudentProfileView!
    @IBOutlet weak var cursusView: CursusView!
    
    var student: Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = self.student {
            navigationHeader.title = student.login
            headerProfileView.takeValuesFromStudent(student: student)
            cursusView.student = student
        } else {
            dismiss(animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    @IBOutlet weak var seeProjectsButton: UIButton!
}
