//
//  RegisterViewModel.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
class RegisterViewModel{
    @Published var error: String?
    var user:User = User()
    @Published var registerSuccess:Bool = false
    @Published var alert: (title: String, message: String)?
    
    private let authService: UserAuthServiceProtocol
    private let detailService : UserDetailsServiceProtocol
    private let imageService : ImageStoreServiceProtocol
    
    init(authService: UserAuthServiceProtocol = FirebaseAuthService() , detailService: UserDetailsServiceProtocol = FirebaseUserDetailsService(), imageService:ImageStoreServiceProtocol = ImageStoreService()) {
        self.authService = authService
        self.detailService = detailService
        self.imageService = imageService
    }
    func userRegister(){
        Task{
            do {
                
                let uid = try await self.authService.register(user: user)
                let success = try await self.detailService.addDetails(documentPath: uid, user: user)
                guard success == true,let image = user.image else { return }
                try await self.imageService.upload(image: image, for: uid)
                registerSuccess = true
                
            } catch  {
                print(error.localizedDescription)
                alert = ("Error", error.localizedDescription)
            }
        }
    }
}
