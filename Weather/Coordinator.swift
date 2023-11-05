//
//  Coordinator.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import UIKit
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = ViewControllerProvider.loginViewController
        loginViewController.coordinator = self
        self.navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func toRegisterViewController(){
        let registerViewController = ViewControllerProvider.toRegisterViewController()
        registerViewController.coordinator = self
        self.navigationController.pushViewController(registerViewController, animated: true)
        
    }
    
    func toProfileViewController(user:User){
        let profileViewController = ViewControllerProvider.toProfileViewController(for: user)
        profileViewController.coordinator = self
        self.navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func toDetailsViewController(item:List){
        let detailsViewController = ViewControllerProvider.toDetailsViewController(for: item)
        detailsViewController.coordinator = self
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
