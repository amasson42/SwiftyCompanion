//
//  SwiftyCompanionAPI.swift
//  SwiftyCompanion
//
//  Created by Axel CAROTINE on 1/29/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

final class SwiftyCompanionAPI {
    
    // The shared static constant approach gives other objects access to the singleton object WeatherAppAPI
    static let shared = SwiftyCompanionAPI()
    
    // The private initializer prevents creating new instances of WeatherAppAPI from outside.
    private init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(with:)), name: .BLDownloadIcon, object: nil)
    }
    
    //private let persistencyManager = PersistencyManager()
    private let httpClient = HTTPClient()
    //private let isOnline = false
    
    /*func getReactions() -> [Reaction] {
     return persistencyManager.getReactions()
     }
     
     func addReaction(_ album: Reaction, at index: Int) {
     persistencyManager.addReaction(album, at: index)
     /*if isOnline {
     httpClient.postRequest("/api/addAlbum", body: album.description)
     }*/
     }
     
     func deleteAlbum(at index: Int) {
     persistencyManager.deleteReaction(at: index)
     /*if isOnline {
     httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
     }*/
     }*/
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
    
//    @objc func downloadImage(with notification: Notification) {
//        guard let userInfo = notification.userInfo,
//            let imageView = userInfo["iconView"] as? UIImageView,
//            let coverUrl = userInfo["iconUrl"] as? String/*,
//             let filename = URL(string: coverUrl)?.lastPathComponent*/ else {
//                return
//        }
//
//        /*if let savedImage = persistencyManager.getImage(with: filename) {
//         imageView.image = savedImage
//         return
//         }*/
//
//        DispatchQueue.global().async {
//            let downloadedIcon = self.httpClient.downloadIcon(coverUrl) ?? UIImage()
//            DispatchQueue.main.async {
//                imageView.image = downloadedIcon
//                //self.persistencyManager.saveImage(downloadedImage, filename: filename)
//            }
//        }
//    }
    
}
