//
//  User.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import UIKit

struct User:Codable{
    var username:String?
    var email:String?
    var password:String?
    var bio:String?
    var image:UIImage?
    init(){
        
    }
    init?(from document: [String: Any]) {
        guard let username = document["username"] as? String,
              let bio = document["bio"] as? String,
              let email = document["email"] as? String else {
            return nil
        }
        
        self.username = username
        self.bio = bio
        self.email = email
        
    }
    enum CodingKeys: String, CodingKey {
        case username, email, password, bio, imageData
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        bio = try container.decode(String.self, forKey: .bio)
        image = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(bio, forKey: .bio)
        
    }
}
