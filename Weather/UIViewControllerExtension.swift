//
//  UIViewControllerExtension.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController{
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    func displayLoader(view:UIView, label: String)-> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .annularDeterminate
        hud.label.text = label
        return hud
    }
   
}
