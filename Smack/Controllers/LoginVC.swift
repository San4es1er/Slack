//
//  LoginVC.swift
//  Smack
//
//  Created by Alex Lebedev on 09.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    // MARK: - Actions
    @IBAction func goBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: .emptyFields)
            return
        }
        FirebaseManager().signIn(email: email, password: password) { [weak self] (error) in
            guard let error = error else {
                return
            }
            self?.showAlert(message: .error(error))
        }
        
    }
    @IBAction func registrationButton(_ sender: Any) {
    performSegue(withIdentifier: TO_REGISTRATION_VC, sender: nil)
    }
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
     
    }
    

  
}
