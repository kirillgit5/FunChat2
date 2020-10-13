//
//  ImageManager.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 13.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class ImageService {
    static let shared = ImageService()
    
    private init() {}
    
    func getImage(from url: URL, complition: @escaping (Data, URLResponse) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            guard  url == responseURL else { return }
            complition(data, response)
        }.resume()
    }
}
