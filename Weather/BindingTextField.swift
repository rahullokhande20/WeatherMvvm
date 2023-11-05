//
//  TextViewExtension.swift
//  Weather
//
//  Created by Rahul Lokhande on 05/10/23.
//

import Foundation
import UIKit
import Combine
/*extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
}
*/
class BindingTextField:UITextField{
    var textChanged :(String)-> Void = {_ in}
    func defaultText (callback : @escaping (String)-> Void){
        guard let text = self.text  else { return}
        callback(text)
    }
    func bind(callback : @escaping (String)-> Void){
        textChanged = callback
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    @objc func textFieldDidChanged(_ textFiled:UITextField){
        if let text = textFiled.text{
            textChanged(text)
        }
    }
}
