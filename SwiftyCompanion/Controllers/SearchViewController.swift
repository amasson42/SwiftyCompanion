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
    
    override func viewDidLoad() {
        
        self.loginView.state = .waitingForAPI
        
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
            (_) in
            DispatchQueue.main.async {
                self.loginView.state = .ready
                self.performSegue(withIdentifier: "SearchStudentSegue", sender: sender)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.startSearch(textField)
        return true
    }
}
