//
//  ProjectsViewController.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 2/1/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class ProjectsViewController: UITableViewController {
    
    var projects: [Project] = []
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.projects.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + self.projects[section].children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
            
            let project = projects[indexPath.section]
            
            let nameLabel = cell.viewWithTag(1) as! UILabel
            let scoreLabel = cell.viewWithTag(2) as! UILabel
            let occurenceLabel = cell.viewWithTag(3) as! UILabel
            
            nameLabel.text = project.name
            if let mark = project.final_mark {
                scoreLabel.text = "\(mark)"
                scoreLabel.textColor = project.validated ? .green : .red
            } else if let status = project.status {
                let strStatus = status.replacingOccurrences(of: "_", with: " ")
                scoreLabel.text = "\(strStatus)"
                scoreLabel.textColor = .yellow
            } else {
                scoreLabel.text = "X"
            }

            if let occurence = project.occurence,
                occurence > 0 {
                occurenceLabel.text = "retry: \(occurence)"
            } else {
                occurenceLabel.text = nil
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenCell", for: indexPath)
            
            let childProject = projects[indexPath.section].children[indexPath.row - 1]
            
            let nameLabel = cell.viewWithTag(1) as! UILabel
            let scoreLabel = cell.viewWithTag(2) as! UILabel
            
            nameLabel.text = childProject.name
            if let mark = childProject.final_mark {
                scoreLabel.text = "\(mark)"
                scoreLabel.textColor = childProject.validated ? .green : .red
            } else if let status = childProject.status {
                scoreLabel.text = "\(status)"
                scoreLabel.textColor = .yellow
            } else {
                scoreLabel.text = "X"
            }

            return cell
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
