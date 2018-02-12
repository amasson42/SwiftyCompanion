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
    var cursusIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = self.student {
            navigationHeader.title = student.login
            navigationHeader.backBarButtonItem?.title = student.login
            headerProfileView.takeValuesFromStudent(student: student)
            cursusView.student = student
            if !student.cursus.isEmpty {
                cursusIndex = 0
            }
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
        if let target = segue.destination as? ProjectsViewController,
            self.cursusIndex >= 0,
            let projects = self.student?.cursus[self.cursusIndex].projectsArray {
            target.projects = projects
        } else {
            print("no projects")
        }
    }
    
    @IBAction func callButton(_ sender: Any) {
        let app = UIApplication.shared
        guard let phoneText = self.student?.phone,
            let phoneCallUrl = URL(string: "tel:\(phoneText)"),
            app.canOpenURL(phoneCallUrl) else {
                let alertController = UIAlertController(title: "Error", message: "Can't make any call", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
        }
        let alertController = UIAlertController(title: "Calling", message: "Are you sure you want to call\n\(phoneText)", preferredStyle: .alert)
        let yesPressed = UIAlertAction(title: "Yes", style: .default) {
            (action) in
            app.open(phoneCallUrl, options: [:], completionHandler: nil)
        }
        let noPressed = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(yesPressed)
        alertController.addAction(noPressed)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func seeProjects(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowProjectsSegue", sender: sender)
    }
    
    @IBAction func changeCursus(_ sender: UISegmentedControl) {
        self.cursusIndex = sender.selectedSegmentIndex
        self.cursusView.setCursus(self.cursusIndex)
    }
    
}


