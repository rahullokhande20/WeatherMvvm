//
//  ViewControllerProvider.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import UIKit
enum ViewControllerProvider {
    static var loginViewController:LoginViewController {
        let viewModel = LoginViewModel()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func toRegisterViewController() -> RegisterViewController {
        let viewModel = RegisterViewModel()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        viewController.viewModel = viewModel
        return viewController
    }
   
    static func toDetailsViewController(for item:List) -> DetailsViewController {
        let viewModel = DetailsViewModel(item:item)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func toProfileViewController(for user:User) -> ProfileViewController {
        let viewModel = ProfileViewModel(user:user)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
}
