//
//  SwiftyCompanionAPI.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

final class SwiftyCompanionAPI {
    
    static let shared = SwiftyCompanionAPI()
    
    private init() {}
    
    private let httpClient = HTTPClient()
    
    var networkActivities: Int = 0 {
        didSet {
            if self.networkActivities == 0 {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                }
            }
        }
    }
    
    func connect(completion: @escaping (_ success: Bool) -> Void) {
        self.networkActivities += 1
        httpClient.connect() { success in
            self.networkActivities -= 1
            completion(success)
        }
    }
    
    func getTokenInfos(completion: @escaping (_ json: [String:Any]?) -> Void) {
        self.networkActivities += 1
        httpClient.getTokenInfos() { json in
            self.networkActivities -= 1
            completion(json)
        }
    }
    
    func getUserInfos(name: String, completion: @escaping (_ json: [String:Any]?) -> Void) {
        self.networkActivities += 1
        httpClient.getUserInfos(name: name) { json in
            self.networkActivities -= 1
            completion(json)
        }
    }
    
    func getExpertise(id: Int, completion: @escaping (_ json: [String:Any]?) -> Void) {
        let strId = id.description
        self.networkActivities += 1
        httpClient.getExpertise(id: strId) { json in
            self.networkActivities -= 1
            completion(json)
        }
    }
    
    func getCoalition(user_id: Int, completion: @escaping (_ json: [String : Any]?) -> Void) {
        let strId = user_id.description
        self.networkActivities += 1
        httpClient.getCoalition(user_id: strId) { json in
            self.networkActivities -= 1
            completion(json)
        }
    }
    
}
