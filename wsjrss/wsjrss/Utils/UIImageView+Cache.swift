//
//  UIImageView+Cache.swift
//  wsjrss
//
//  Created by Slobodan Kovrlija on 2/2/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageWith(urlString: String) {
        
        // clear image view before setting new image
        image = nil
        
        // set image from cache if available
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        // otherwise, download it
        guard let imageUrl = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let imageData = data,
                let downloadedImage = UIImage(data: imageData) {
                DispatchQueue.main.async(execute: {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    self.image = downloadedImage
                })
            }
            if error != nil {
                // set default image in case of error
                self.image = UIImage(named: "WSJ_Logo_black_social")
                return
            }
        }
        task.resume()
    }
}
