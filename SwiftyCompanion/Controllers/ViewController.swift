//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftyCompanionAPI.shared.connect() { success in
            if success {
                SwiftyCompanionAPI.shared.getUserInfos(name: "acarotin") { json in
                    if let j = json {
                        print(j)
                    } else {
                        print("Nothing")
                    }
                }
            } else {
                print("FALSE")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

