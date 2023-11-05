//
//  ImageStoreService.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import FirebaseStorage
import UIKit
protocol ImageStoreServiceProtocol{
    func upload(image:UIImage,for userId:String ) async throws -> Bool
    func getImage(from uid:String) async throws -> UIImage
}
class ImageStoreService:ImageStoreServiceProtocol{
    func upload(image:UIImage,for userId:String ) async throws -> Bool{
        let storageRef = Storage.storage().reference().child("userImages/\(userId).jpg")

            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to JPEG data"])
            }

            return try await withCheckedThrowingContinuation { continuation in
                storageRef.putData(imageData, metadata: nil) { _, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            } else {
                                continuation.resume(returning: true)
                            }
                        }
                    }
                }
            }
    }
    func getImage(from uid:String) async throws -> UIImage{
        let storageRef = Storage.storage().reference().child("userImages/\(uid).jpg")

        let data = try await withCheckedThrowingContinuation { (continuation:  CheckedContinuation<Data, Error>) in
               storageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in // 10MB limit as an example
                   if let error = error {
                       continuation.resume(throwing: error)
                   } else if let data = data {
                       continuation.resume(returning: data)
                   } else {
                       continuation.resume(throwing: NSError(domain: "FirebaseStorage", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get image data"]))
                   }
               }
           }

           guard let image = UIImage(data: data) else {
               throw NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to UIImage"])
           }

           return image
    }
}
