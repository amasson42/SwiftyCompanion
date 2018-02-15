//
//  SearchViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var loginView: LoginView!
    var student: Student?
    
    override func viewDidLoad() {
        
        self.loginView.state = .waitingForAPI
        self.loginView.loginTextDelegate = self
        
        SwiftyCompanionAPI.shared.connect {
            (success) in
            if success {
                DispatchQueue.main.async {
                    self.notificationRecievedToken()
                }
            } else {
                // TODO: - handle error signal
            }
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Notification recieving
    
    @objc
    func notificationRecievedToken() {
        self.loginView.state = .ready
    }
    
    // MARK: - Navigation

    @IBAction func startSearch(_ sender: Any) {
        guard let login = self.loginView.loginField.text,
            !login.isEmpty else {
            return
        }
        self.loginView.state = .searching
        SwiftyCompanionAPI.shared.getUserInfos(name: login) {
            (json) in
            DispatchQueue.main.async {
                self.loginView.state = .ready
            }
            guard let json = json else {
                // TODO: - handle student not found
                return
            }
            if let student = Student(json: json) {
                SwiftyCompanionAPI.shared.getCoalition(user_id: student.id) {
                    (json) in
                    if let json = json {
                        student.addCoalition(json: JSONObject(json: json))
                    }
                    self.student = student
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "SearchStudentSegue", sender: sender)
                    }
                }
            } else {
                // TODO: - handle wrong student
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? StudentViewController {
            target.student = self.student
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.startSearch(textField)
        return true
    }
    
}
