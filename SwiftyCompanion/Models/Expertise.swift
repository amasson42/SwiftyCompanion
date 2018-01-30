//
//  Expertise.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Expertise {
    
    private var _id : Int?
    private var _name : String?
    private var _kind : String?
    private var _url : String?
    
    init?(expertise: JSONObject) {
        
        if let id = expertise["id"]?.integerValue {
            
            self._id = id
            
        }
        
        if let name = expertise["name"]?.stringValue {
            
            self._name = name
            
        }
        
        if let kind = expertise["kind"]?.stringValue {
            
            self._kind = kind
            
        }
        
        if let url = expertise["url"]?.stringValue {
            
            self._url = url
            
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
    
    var url : String {
        get {
            if let u = _url {
                
                return u
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
