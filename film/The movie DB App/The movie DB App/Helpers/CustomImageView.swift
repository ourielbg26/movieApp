//
//  CustomImageView.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    // MARK: Properties
    var imageUrlString: String?
    
    func loadQuestionMarkImage() {
        image = UIImage(named: Constants.Image.questionMark)
    }
    
    func loadImageUsingUrlString(urlString: String, completion: @escaping (_ finish: Bool?) -> ()) {
        imageUrlString = urlString
        
        if let url = URL(string: urlString) {
            if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
                self.image = imageFromCache
                completion(true)
                return
            }
            
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    
                    if imageToCache != nil {
                        imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    }
                    
                    completion(true)
                }
                
            }).resume()
        }
    }
}
