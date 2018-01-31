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
    private var _value: Int?
    
    init?(expertise: JSONObject) {
        
        if let id = expertise["expertise_id"]?.integerValue {
            
            self._id = id
            
        }
        
        if let value = expertise["value"]?.integerValue {
            
            self._value = value
            
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
    
    var name : String? {
        get {
            
            return _name
            
        }
    }
    
    var value : Int {
        get {
            if let v = _value {
                
                return v
                
            } else {
                
                return -1
                
            }
        }
    }
    
    func loadName(completion: (() -> ())? = nil) {
        
        if let id = self._id {
            
            SwiftyCompanionAPI.shared.getExpertise(id: id) {
                (json) in
                
                guard let json = json else {
                    completion?()
                    return
                }
                
                let jsonObject = JSONObject(json: json)
                
                self._name = jsonObject["name"]?.stringValue
                
                completion?()
            }
            
        }
        
    }
    
}
