//
//  Achievement.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Achievement {
    
    private var _id : Int?
    private var _name : String?
    private var _kind : String?
    private var _description : String?
    private var _visible : Bool?
    private var _tier : String?
    private var _nbr_of_success : Int?
    private var _image : String?
    
    init?(achievement: JSONObject) {
        
        if let id = achievement["id"]?.integerValue {
            
            self._id = id
            
        }
        
        if let name = achievement["name"]?.stringValue {
            
            self._name = name
            
        }
        
        if let kind = achievement["kind"]?.stringValue {
            
            self._kind = kind
            
        }
        
        if let description = achievement["description"]?.stringValue {
            
            self._description = description
            
        }
        
        if let visible = achievement["visible"]?.booleanValue {
            
            self._visible = visible
            
        }
        
        if let tier = achievement["tier"]?.stringValue {
            
            self._tier = tier
            
        }
        
        if let nbr_of_success = achievement["nbr_of_success"]?.integerValue {
            
            self._nbr_of_success = nbr_of_success
            
        }
        
        if let image = achievement["image"]?.stringValue {
            
            self._image = image
            
        }
        
    }
    
    var id : Int {
        get {
            if let i = _id {
                
                return i
                
            } else {
                
                return -1
                
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
    
    var kind : String {
        get {
            if let k = _kind {
                
                return k
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var description : String {
        get {
            if let d = _description {
                
                return d
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var visible : String {
        get {
            if let v = _visible {
                
                return String(describing: v)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var tier : String {
        get {
            if let t =  _tier {
                
                return t
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var nbr_of_success : String {
        get {
            if let n = _nbr_of_success {
                
                return String(describing: n)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var image : String {
        get {
            if let i = _image {
                
                return i
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
