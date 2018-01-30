//
//  WebImageView.swift
//  SwiftyCompanion
//
//  Created by Arthur MASSON on 1/30/18.
//  Copyright © 2018 Arthur MASSON. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    
    var imageUrl: String?
    private(set) var downloadError: Error?
    private var downloadTask: URLSessionDataTask?
    
    func reloadImage(errorHandling: (() -> ())? = nil) {
        if let downloadTask = self.downloadTask {
            downloadTask.cancel()
            self.downloadTask = nil
        }
        if let imageUrl = imageUrl,
            let url = URL(string: imageUrl) {
            
            loaderView?.startAnimating()
            loaderView?.isHidden = false
            
            self.downloadTask = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                let image: UIImage?
                self.downloadError = error
                if let data = data {
                    image = UIImage(data: data)
                } else {
                    errorHandling?()
                    image = #imageLiteral(resourceName: "empty")
                }
                DispatchQueue.main.async {
                    self.loaderView?.stopAnimating()
                    self.loaderView?.isHidden = true
                    self.image = image
                }
                self.downloadTask = nil
            }
            self.downloadTask?.resume()
        }
    }
}
