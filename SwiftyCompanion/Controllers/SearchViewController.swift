//
//  SearchViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notificationRecievingToken),
                                               name: NSNotification.Name("token"),
                                               object: nil)
        
        self.activityIndicator.startAnimating()
        self.loadingLabel.text = "recieving token"
        self.loginField.isHidden = true
        self.searchButton.isHidden = true
        self.loginField.alpha = 0
        self.searchButton.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            NotificationCenter.default.post(name: NSNotification.Name("token"), object: nil)
        }
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Notification recieving
    
    @objc
    func notificationRecievingToken() {
        
        self.activityIndicator.stopAnimating()
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.1,
                       options: .curveLinear,
                       animations: {
                        self.activityIndicator.alpha = 0
                        self.loadingLabel.alpha = 0
                        self.loginField.alpha = 1
                        self.searchButton.alpha = 1
                        
                        self.activityIndicator.isHidden = true
                        self.loadingLabel.isHidden = true
                        
                        self.loginField.isHidden = false
                        self.searchButton.isHidden = false
        }) { (_) in
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
}

extension SearchViewController: UITextFieldDelegate {
    
}
