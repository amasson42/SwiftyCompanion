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
    
    private var firstname: String?
    private var lastname: String?
    private var fullname: String?
    private var location: String?
    private var login: String?
    private var email: String?
    private var mobile: String?
    private var level: Double?
    private var wallet: Int?
    private var correction: Int?
    private var img_url: String?
    private var skillsArray: NSArray?
    private var projectsArray: NSArray?
    
//
//    func contains(date: String?) -> DailyForecast? {
//        guard let d = date else {
//            return nil
//        }
//        for case let df in self.dailyForecast {
//            if df.date == d {
//                return df
//            }
//        }
//        return nil
//    }
    
    init?(json: [String: Any]) {
        
        let json = JsonObject(json: json)
        print(json.description)
        
        
        
    }
    
}
