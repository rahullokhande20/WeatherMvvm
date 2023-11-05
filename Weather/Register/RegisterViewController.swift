//
//  RegisterViewController.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import UIKit
import Combine
import SwiftUI
import MBProgressHUD
class RegisterViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var password: BindingTextField!
    @IBOutlet weak var displayPicture: UIImageView!
    
    @IBOutlet weak var bio: BindingTextField!
    @IBOutlet weak var username: BindingTextField!
    @IBOutlet weak var confirmPassword: BindingTextField!
    @IBOutlet weak var email: BindingTextField!
    
    var hud: MBProgressHUD?
    weak var coordinator: MainCoordinator?
    var viewModel : RegisterViewModel!
    private var bindings:Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    @IBAction func uploadDisplayPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true // set to false if you don't want to allow editing
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            self.showAlert(title: "Warning", message: "Camera not available.")
            print("Camera not available.")
        }
    }
    @IBAction func signupTapped(_ sender: Any) {
        self.hud = displayLoader(view: self.view, label: "Registering User")
        self.viewModel.userRegister()
    }
    
    
    func setupBindings(){
        bindings = [
            viewModel.$registerSuccess.receive(on: RunLoop.main)
                .sink{ [weak self] success in
                    self?.hud?.hide(animated: true)
                    if success{
                        guard let user = self?.viewModel.user else {return}
                        self?.coordinator?.toProfileViewController(user: user)
                    }
                },
            viewModel.$alert.receive(on: RunLoop.main)
                .sink{ [weak self] alert in
                    self?.hud?.hide(animated: true)
                    guard let alert = alert else { return }
                    self?.showAlert(title: alert.title, message: alert.message)
                    
                }
        ]
        
        email.defaultText { [weak self] text in
            self?.viewModel.user.email = text
        }
        email.bind { [weak self] text in
            self?.viewModel.user.email = text
            
            print("text ,%@",text)
        }
        password.defaultText { [weak self] text in
            self?.viewModel.user.password = text
        }
        password.bind {[weak self]  text in
            self?.viewModel.user.password = text
        }
        
        username.defaultText { [weak self] text in
            self?.viewModel.user.username = text
        }
        username.bind {[weak self]  text in
            self?.viewModel.user.username = text
        }
        
        bio.defaultText { [weak self] text in
            self?.viewModel.user.bio = text
        }
        bio.bind {[weak self]  text in
            self?.viewModel.user.bio = text
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.editedImage] as? UIImage {
            self.displayPicture.image = chosenImage
            self.viewModel.user.image = chosenImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
