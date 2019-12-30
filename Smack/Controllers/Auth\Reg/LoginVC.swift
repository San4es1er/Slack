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
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: .emptyFields)
            return
        }
        FirebaseManager().signIn(email: email, password: password) { [weak self] (error) in
            if let error = error{
                self?.showAlert(message: .error(error))
                return
            }
            FirebaseManager().getUserData { (error) in
                if let error = error{
                    self?.showAlert(message: .error(error))
                    return
                }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SWRevealViewController")
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func goToRegButton(_ sender: UIButton) {
        let vc: RegistrationVC = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "RegistrationVC")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
