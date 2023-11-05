//
//  UserAuthService.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import Firebase

protocol UserAuthServiceProtocol{
    func login(email:String, password:String) async throws->String
    func register(user:User) async throws -> String
}
class FirebaseAuthService:UserAuthServiceProtocol{
    func register(user: User) async throws ->String {
        return try await withCheckedThrowingContinuation { continuation in
            guard let email = user.email, let password = user.password else { return }
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult.user.uid)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"]))
                }
            }
        }
    }
    
    func login(email: String, password: String) async throws-> String{
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult.user.uid)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred during login"]))
                }
            }
        }
    }
    
    
}
