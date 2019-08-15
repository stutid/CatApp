//
//  Extensions.swift
//  CatApp
//
//  Created by Stuti on 03/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}

extension UIViewController {
    func showAlert(with message: String) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Key.OK.title, style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

extension UIImageView {
    
    func downloadImage(from url: URL?) {
        guard let url = url else { return }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            set(cachedImage)
        } else {
            let request = ApiManager.shared.createRequest(url: url, method: .get)
            ApiManager.shared.fetch(request: request) { (data, error) in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                self.set(image)
            }
        }
    }
    
    func set(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
