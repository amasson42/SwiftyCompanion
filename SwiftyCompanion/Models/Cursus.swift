//
//  Cursus.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Cursus {
    
    var id : Int = 0 
    private var _name : String?
    private var _level : Double?
    private var _grade : String?
    var skillsArray : [Skill] = []
    var projectsArray : [Project] = []
    
    init?(json : JSONObject) {
            
        if let id = json["cursus"]?["id"]?.integerValue {
                
            self.id = id
                
        } else {
                
            return nil
            
        }
            
        if let n = json["cursus"]?["name"]?.stringValue {
                
            self._name = n
                
        }
            
        if let l = json["level"]?.floatValue {
                
            self._level = l
                
        }
            
        if let g = json["grade"]?.stringValue {
                
            self._grade = g
                
        }
            
        if let skills = json["skills"]?.arrayValue {
                
            for skill in skills {
                    
                if let s = Skill(skill : skill) {
                        
                    skillsArray.append(s)
                    
                }
                
            }
            
        }
        
        
    }
    
    func appendProjectToProject(project: Project, id: Int) {
        
        for p in self.projectsArray {
            
            if p.id == id {
                
                p.children.append(project)
                
            }
            
        }
        
    }
    
    var name : String {
        get {
            if let n = _name {
                
                return n
                
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
    
    var grade : String {
        get {
            if let g = _grade {
                
                return g
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
