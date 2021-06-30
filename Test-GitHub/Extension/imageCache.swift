//
//  imageCache.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 30.06.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (Bool) -> ()) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            completion(true)
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error ?? "")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                   
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                    
                    completion(true)
                }
            }
            
        }).resume()
    }
    
}

