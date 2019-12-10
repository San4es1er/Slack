//
//  LoginVC.swift
//  Smack
//
//  Created by Alex Lebedev on 09.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    // MARK: - Actions
    @IBAction func goBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginButton(_ sender: Any) {
        
    }
    @IBAction func registrationButton(_ sender: Any) {
    performSegue(withIdentifier: REGISTRATION_VIEW_CONTROLLER, sender: nil)
    }
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

  
}
