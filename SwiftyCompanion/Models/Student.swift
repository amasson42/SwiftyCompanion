//
//  Student.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Student: CustomStringConvertible {
    var description: String {
        
        return "\(dump(self))"
        
    }
    
    private var _firstname: String?
    private var _lastname: String?
    private var _displayname: String?
    private var _location: String?
    private var _login: String?
    private var _email: String?
    private var _phone: String?
    private var _level: Double?
    private var _wallet: Int?
    private var _correction_points: Int?
    private var _profile_image_url: String?
    var cursus: [Cursus] = []
    
    init?(json: [String: Any]) {
        
        let json = JSONObject(json: json)
        
        if let fn = json["first_name"]?.stringValue {
            
            self._firstname = fn
            
        }
        
        if let ln = json["last_name"]?.stringValue {
            
            self._lastname = ln
            
        }
        
        if let dn = json["displayname"]?.stringValue {
            
            self._displayname = dn
            
        }
        
        if let l = json["location"]?.stringValue {
            
            self._location = l
            
        }
        
        if let l = json["login"]?.stringValue {
            
            self._login = l
            
        }
        
        if let e = json["email"]?.stringValue {
            
            self._email = e
            
        }
        
        if let p = json["phone"]?.stringValue {
            
            self._phone = p
            
        }
        
        if let l = json["level"]?.floatValue {
            
            self._level = l
            
        }
        
        if let w = json["wallet"]?.integerValue {
            
            self._wallet = w
            
        }
        
        if let cp = json["correction_point"]?.integerValue {
            
            self._correction_points = cp
            
        }
        
        if let cursus_users = json["cursus_users"] {
            
            if let cur = cursus_users.arrayValue {
                
                for c in cur {
                    
                    if let new_cursus = Cursus(json: c) {
                        
                        self.cursus.append(new_cursus)
                        
                    }
                    
                }
                
            }
            
        }
        
        if let projects_users = json["projects_users"] {
        
            if let pro = projects_users.arrayValue {
             
                for p in pro {
                    
                    if let new_project = Project(project: p) {
                        
                        self.appendProjectToCursus(cursus: cursus, project: new_project)
                        
                    }
                    
                }
                
            }
            
        
        }
        
        //dump(cursus)
        
    }
    
    func appendProjectToCursus(cursus : [Cursus], project: Project) {
        
        for c in cursus {
            
            if project.cursus_ids.contains(c.id) {
                
                if let parent_id = project.parent_id {
                    
                    c.appendProjectToProject(project: project, id: parent_id)
                
                } else {
                    
                    c.projectsArray.append(project)
                
                }
                
            }
            
        }
        
    }
    
    var firstname : String {
        get {
            if let fn = _firstname {
                
                return fn
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var lastname : String {
        get {
            if let ln = _lastname {
                
                return ln
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var displayname : String {
        get {
            if let dn = _displayname {
                
                return dn
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var location : String {
        get {
            if let l = _location {
                
                return l
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var login : String {
        get {
            if let l = _login {
                
                return l
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var email : String {
        get {
            if let e = _email {
                
                return e
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var phone : String {
        get {
            if let p = _phone {
                
                return p
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var level : String {
        get {
            if _level != nil {
                
                return String(describing: _level)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var wallet : String {
        get {
            if _wallet != nil {
                
                return String(describing: _wallet)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var correction_points : String {
        get {
            if _correction_points != nil {
                
                return String(describing: _correction_points)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var profile_image_url : String {
        get {
            if let p = _profile_image_url {
                
                return p
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
