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
    private var _status: String?
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
        
        if let o = project["occurrence"]?.integerValue {
            
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
        
        if let status = project["status"]?.stringValue {
            
            self._status = status
            
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
    
    var validated : Bool {
        get {
            if let v = _validated {
                
                return v
                
            } else {
                
                return false
                
            }
        }
    }
    
    var occurence : Int? {
        get {
            
            return _occurence
            
        }
    }
    
    var final_mark : Int? {
        get {
            
            return _final_mark
            
        }
    }
    
    var status : String? {
        get {
            
            return _status
            
        }
    }
}
