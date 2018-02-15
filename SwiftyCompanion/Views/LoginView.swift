//
//  LoginView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    enum State {
        case none
        case waitingForAPI
        case ready
        case searching
    }
    var state: State = .none {
        didSet {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: self.updateUI)
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    weak var loginTextDelegate: UITextFieldDelegate?
    
    func updateUI() {
        switch self.state {
        case .none:
            
            activityIndicator.alpha = 0
            loadingLabel.alpha = 0
            loginField.alpha = 0
            searchButton.alpha = 0
            
        case .waitingForAPI:
            
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            
            loadingLabel.text = "recieving token"
            loadingLabel.alpha = 1
            
            loginField.text = ""
            loginField.alpha = 0
            
            searchButton.alpha = 0
            
        case .ready:
            
            activityIndicator.stopAnimating()
            activityIndicator.alpha = 0
            
            loadingLabel.text = ""
            loadingLabel.alpha = 0
            
            loginField.text = ""
            loginField.alpha = 1
            loginField.delegate = self.loginTextDelegate
            
            searchButton.alpha = 1
            searchButton.isEnabled = true
            
        case .searching:
            
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
            
            loadingLabel.text = "searching student"
            loadingLabel.alpha = 1
            
            loginField.alpha = 1
            loginField.delegate = nil
            
            searchButton.alpha = 1
            searchButton.isEnabled = false
            
        }
    }
}
