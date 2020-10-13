//
//  UIImageView + Extension.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 25.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
    
    func customizeAddPhotoImageView() {
        self.image = #imageLiteral(resourceName: "avatar")
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

extension UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { image = UIImage(named: "avatar") ; return }
        if let cachedImage = getCacheImage(url: url) {
            image = cachedImage
            return
        }
        
        ImageService.shared.getImage(from: url) {[weak self] (data, response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            self.saveDataToCach(with: data, response: response)
        }
    }
    
    private func getCacheImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let chacheedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: chacheedResponse.data)
        }
       return nil
    }
    
    private func saveDataToCach(with data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let chacheedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(chacheedResponse, for: urlRequest)
         
    }
}
