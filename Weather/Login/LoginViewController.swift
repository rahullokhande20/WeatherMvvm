//
//  LoginViewController.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import UIKit
import Combine
import MBProgressHUD
class LoginViewController: UIViewController {
    @IBOutlet weak var email: BindingTextField!
    
    @IBOutlet weak var password: BindingTextField!
    var hud: MBProgressHUD?
    weak var coordinator: MainCoordinator?
    var viewModel : LoginViewModel!
    private var bindings:Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
        // Do any additional setup after loading the view.
    }
    func setupBindings(){
        bindings = [
            viewModel.$user.receive(on: RunLoop.main)
                .sink{ [weak self] user in
                    self?.hud?.hide(animated: true)
                    guard let user = user else { return}
                    self?.coordinator?.toProfileViewController(user: user)
                },
            
            
            viewModel.$alert.receive(on: RunLoop.main)
                .sink{ [weak self] alert in
                    self?.hud?.hide(animated: true)
                    guard let alert = alert else { return }
                    self?.showAlert(title: alert.title, message: alert.message)
                    
                }
        ]
        email.defaultText { [weak self] text in
            self?.viewModel.email = text
        }
        email.bind { [weak self] text in
            self?.viewModel.email = text
        }
        password.defaultText { [weak self] text in
            self?.viewModel.password = text
        }
        password.bind {[weak self]  text in
            self?.viewModel.password = text
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        hud = self.displayLoader(view: self.view, label: "Logging")
        viewModel.userLogin()
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        self.coordinator?.toRegisterViewController()
    }
    
    
    
}
