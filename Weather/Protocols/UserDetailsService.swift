//
//  UserDetailsService.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import FirebaseFirestore
protocol UserDetailsServiceProtocol{
    func addDetails(documentPath:String, user:User) async throws -> Bool
    func getDetails(from documentPath:String)  async throws ->User
    
    
}
class FirebaseUserDetailsService:UserDetailsServiceProtocol{
    func addDetails(documentPath: String, user: User) async throws -> Bool {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "username": user.username,
            "bio": user.bio,
            "email": user.email
        ]
        return try await withCheckedThrowingContinuation { continuation in
            let userRef = db.collection("users").document(documentPath)
            userRef.setData(userData) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func getDetails(from documentPath: String) async throws ->User {
        let db = Firestore.firestore()
        return try await withCheckedThrowingContinuation { continuation in
            let userRef = db.collection("users").document(documentPath)
            
            userRef.getDocument { (document, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let document = document, document.exists, let data = document.data(), let user = User(from: data) {
                    continuation.resume(returning: user)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found or data format incorrect"]))
                }
            }
        }
    }
}
