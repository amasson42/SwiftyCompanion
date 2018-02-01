//
//  Student.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Student {
    
    var id : Int = 0
    private var _firstname: String?
    private var _lastname: String?
    private var _displayname: String?
    private var _location: String?
    private var _login: String?
    private var _email: String?
    private var _phone: String?
    private var _wallet: Int?
    private var _correction_points: Int?
    private var _profile_image_url: String?
    var cursus: [Cursus] = []
    var achievements: [Achievement] = []
    var expertises: [Expertise] = []
    var coalition: Coalition?
    
    init?(json: [String: Any]) {
        
        if json.count == 0 {
            return nil
        }
        
        let json = JSONObject(json: json)
        
        if let id = json["id"]?.integerValue {
            
            self.id = id
            
        }
        
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
        
        if let w = json["wallet"]?.integerValue {
            
            self._wallet = w
            
        }
        
        if let cp = json["correction_point"]?.integerValue {
            
            self._correction_points = cp
            
        }
        
        if let image_url = json["image_url"]?.stringValue {
            
            self._profile_image_url = image_url
            
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
        
        if let achievements_array = json["achievements"] {
            
            if let achievements = achievements_array.arrayValue {
                
                for achievement in achievements {
                    
                    if let new_achievement = Achievement(achievement: achievement) {
                        
                        self.achievements.append(new_achievement)
                        
                    }
                    
                }
                
            }
            
        }
        
        if let expertise_array = json["expertises_users"] {
            
            if let expertises = expertise_array.arrayValue {
            
                for expertise in expertises {
                    
                    if let new_expertise = Expertise(expertise: expertise) {
                        
                        self.expertises.append(new_expertise)
                        
                    }
            
                }
                
            }
            
        }
        
//        if let expertise_array = json["expertises_users"] {
//
//            if let expertises = expertise_array.arrayValue {
//
//                for expertise in expertises {
//
//                    if let id = expertise["expertise_id"]?.stringValue {
//
//                        SwiftyCompanionAPI.shared.getExpertise(id: id) { json in
//
//                            let expertise = JSONObject(json: json)
//
//                            if let new_expertise = Expertise(expertise: expertise) {
//
//                                self.expertises.append(new_expertise)
//
//                            }
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//        }
        if self._login == "amasson" {
            let uselessSkill = Skill(skill: .dictionnary([
                "id": .integer(0),
                "name": .string("Wasting time on useless graphical bonus"),
                "level": .float(20.0)
                ]))!
            self.cursus.first?.skillsArray.append(uselessSkill)
        }
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
    
    func addCoalition(json : JSONObject) {
        
        self.coalition = Coalition(coalition: json)
        
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
    
    var wallet : String {
        get {
            if let w = _wallet {
                
                return String(describing: w)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var correction_points : String {
        get {
            if let c = _correction_points {
                
                return String(describing: c)
                
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
