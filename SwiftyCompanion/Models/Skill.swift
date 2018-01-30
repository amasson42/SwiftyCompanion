//
//  Skill.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Skill {
    
    private var _id : Int?
    private var _name : String?
    private var _level : Double?
    
    init?(skill : JSONObject) {
        
        if let id = skill["id"]?.integerValue {
            
            self._id = id
            
        }
        
        if let name = skill["name"]?.stringValue {
            
            self._name = name
            
        }
        
        if let l = skill["level"]?.floatValue {
            
            self._level = l
            
        }
        
    }
    
    var id : String {
        get {
            if _id != nil {
                
                return String(describing: _id)
                
            } else {
                
                return "Unavailable"
                
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
    
}
