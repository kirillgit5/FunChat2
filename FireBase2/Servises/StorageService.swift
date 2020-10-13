//
//  StorageService.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 13.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    private let storageReference = Storage.storage().reference()
    
    private var userPhotosReference: StorageReference {
        return storageReference.child("userPhotos")
    }
    
    private lazy var metaDataForImage: StorageMetadata = {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        return metaData
    }()
    
    private init() {}
    
    func loadUserPhoto(userPhoto: UIImage, userId: String, complition: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = userPhoto.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.5) else { return }
        userPhotosReference.child(userId).putData(imageData, metadata: metaDataForImage) {[unowned self] (metadata, error) in
            guard let _ = metadata else { complition(.failure(error!)) ; return }
            self.userPhotosReference.child(userId).downloadURL { (url, error) in
                guard let url = url else { complition(.failure(error!)) ; return }
                complition(.success(url))
                return
            }
        }
        
    }
    
}
