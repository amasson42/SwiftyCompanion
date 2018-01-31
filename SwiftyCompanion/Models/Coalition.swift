//
//  Coalition.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/31/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation

class Coalition {
    
    private var _id : Int?
    private var _name : String?
    private var _score : Int?
    private var _image_url : String?
    private var _color : String?
    
    init?(coalition: JSONObject) {
        
        if let id = coalition["id"]?.integerValue {
            
            self._id = id
            
        }
        
        if let name = coalition["name"]?.stringValue {
            
            self._name = name
            
        }
        
        if let score = coalition["score"]?.integerValue {
            
            self._score = score
            
        }
        
        if let url = coalition["image_url"]?.stringValue {
            
            self._image_url = url
            
        }
        
        if let color = coalition["color"]?.stringValue {
            
            self._color = color
            
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
    
    var score : String {
        get {
            if let s = _score {
                
                return String(describing: s)
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var url : String {
        get {
            if let i = _image_url {
                
                return i
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
    var color : String {
        get {
            if let c = _color {
                
                return c
                
            } else {
                
                return "Unavailable"
                
            }
        }
    }
    
}
