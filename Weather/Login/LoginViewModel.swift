//
//  LoginViewModel.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
class LoginViewModel{
    @Published var user:User?
    var email:String?
    var password:String?
    @Published var alert: (title: String, message: String)?
    private let authService: UserAuthServiceProtocol
    private let detailService : UserDetailsServiceProtocol
    private let imageService : ImageStoreServiceProtocol
    init(authService: UserAuthServiceProtocol = FirebaseAuthService() , detailService: UserDetailsServiceProtocol = FirebaseUserDetailsService(), imageService:ImageStoreServiceProtocol = ImageStoreService()) {
        self.authService = authService
        self.detailService = detailService
        self.imageService = imageService
    }
    func userLogin(){
        Task{
            do {
                guard let email = email, let password = password else {
                    print("enter email and password")
                    return
                }
                let uid = try await self.authService.login(email: email, password: password)
                var result = try await self.detailService.getDetails(from: uid)
                let profileImage = try await self.imageService.getImage(from: uid)
                result.image = profileImage
                user = result
               
                
            } catch  {
                print(error.localizedDescription)
                alert = (title:"Error", message: error.localizedDescription)
            }
        }
    }
    
}
