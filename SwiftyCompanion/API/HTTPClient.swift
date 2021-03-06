//
//  HTTPClient.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import Foundation
import UIKit

class HTTPClient {
    
    private let url42         : String = "https://api.intra.42.fr"
    private let uid           : String = "8f804050521ce1105b67d2eb687a4f8ba8bf241c591f38cf84092547ac29cee7"
    private let secret        : String = "8cba126ab2b9e1111f04941ae40f6ce5bcbf07579a4e6bec400035c93b1582fb"
    private var access_token  : String?
    private var created_at    : Double?
    private var expires_in    : Double?
    private var recreateTimer : Timer?
    
    func connect(completion: @escaping (_ success: Bool) -> Void) {
        let postData: [String:String] = [
            "grant_type"    : "client_credentials",
            "client_id"     : self.uid,
            "client_secret" : self.secret
        ]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: postData, options: .prettyPrinted) {
            if let url = URL(string: "\(self.url42)/oauth/token") {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if let error = error {
                        print("Error:", error)
                    } else if let d = data {
                        do {
                            if let respJson: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                self.access_token = respJson["access_token"] as? String
                                self.created_at = respJson["created_at"] as? Double
                                self.expires_in = respJson["expires_in"] as? Double
                                if let expires_in = self.expires_in {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + expires_in) {
                                        self.connect(completion: {_ in })
                                    }
                                }
                                completion(true)
                            }
                        } catch {
                            completion(false)
                        }
                    }
                }
                task.resume()
            } else {
                completion(false)
            }
        }
    }
    
    func getTokenInfos(completion: @escaping (_ json: [String : Any]?) -> Void) {
        if let url = URL(string: "\(self.url42)/oauth/token/info") {
            var request = URLRequest(url: url)
            if let token = self.access_token {
                request.httpMethod = "GET"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if error != nil {
                        print("Error:", error!)
                    } else if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                                completion(json)
                            }
                        } catch ( _) {
                            completion(nil)
                        }
                    }
                }
                task.resume()
            }
        } else {
            completion(nil)
        }
    }
    
    func getUserInfos(name: String, completion: @escaping (_ json: [String : Any]?) -> Void) {
        if let url = URL(string: "\(self.url42)/v2/users/\(name)") {
            var request = URLRequest(url: url)
            if let token = self.access_token {
                request.httpMethod = "GET"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if error != nil {
                        print("Error:", error!)
                    } else if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                                completion(json)
                            }
                        } catch ( _) {
                            completion(nil)
                        }
                    }
                }
                task.resume()
            }
        } else {
            completion(nil)
        }
    }
    
    func getExpertise(id: String, completion: @escaping (_ json: [String : Any]?) -> Void) {
        if let url = URL(string: "\(self.url42)/v2/expertises/\(id)") {
            var request = URLRequest(url: url)
            if let token = self.access_token {
                request.httpMethod = "GET"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if error != nil {
                        print("Error:", error!)
                    } else if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
                                completion(json)
                            }
                        } catch ( _) {
                            completion(nil)
                        }
                    }
                }
                task.resume()
            }
        } else {
            completion(nil)
        }
    }
    
    func getCoalition(user_id: String, completion: @escaping (_ json: [String : Any]?) -> Void) {
        if let url = URL(string: "\(self.url42)/v2/users/\(user_id)/coalitions") {
            var request = URLRequest(url: url)
            if let token = self.access_token {
                request.httpMethod = "GET"
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if error != nil {
                        print("Error:", error!)
                    } else if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                                if json.count == 0 {
                                    completion(nil)
                                } else if let j = json[0] as? [String : Any] {
                                    completion(j)
                                } else {
                                    completion(nil)
                                }
                                
                            }
                        } catch (let err) {
                            print(err)
                            completion(nil)
                        }
                    }
                }
                task.resume()
            }
        } else {
            completion(nil)
        }
    }
    
}
