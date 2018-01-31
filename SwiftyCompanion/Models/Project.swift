//
//  Project.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Project {
    
    var id : Int = 0
    private var _name : String?
    private var _validated : Bool?
    private var _occurence : Int?
    private var _final_mark : Int?
    var parent_id : Int?
    var cursus_ids : [Int] = []
    var children : [Project] = []
    
    init?(project: JSONObject) {
        
        if let id = project["project"]?["id"]?.integerValue {
            
            self.id = id
            
        } else {
            
            return nil
            
        }
        
        if let name = project["project"]?["name"]?.stringValue {
            
            self._name = name
            
        }
        
        if let v = project["validated?"]?.booleanValue {
            
            self._validated = v
            
        }
        
        if let o = project["occurence"]?.integerValue {
            
            self._occurence = o
            
        }
        
        if let f = project["final_mark"]?.integerValue {
            
            self._final_mark = f
            
        }
        
        if let pid = project["project"]?["parent_id"] {

            if !pid.isNull {
                
                if let p = project["project"]?["parent_id"]?.integerValue {
                    
                    self.parent_id = p
                    
                }
                
            }
            
        }
        
        
        if let cursus_ids = project["cursus_ids"]?.arrayValue {
            
            for ci in cursus_ids {
                
                if let id = ci.integerValue {
                    
                    self.cursus_ids.append(id)
                
                }
            
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
    
    var validated : String {
        get {
            if let v = _validated {
                
                return String(describing: v)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var occurence : String {
        get {
            if let o = _occurence {
                
                return String(describing: o)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var final_mark : String {
        get {
            if let f = _final_mark {
                
                return String(describing: f)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
