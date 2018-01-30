//
//  StudentViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {
    
    @IBOutlet weak var headerProfileView: StudentProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerProfileView.takeValuesFromStudent(student: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}