//
//  RegistationViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 10.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    // MARK: - Actions
    
    
    
    @IBAction func registrationButton(_ sender: UIButton) {
    }
    
    @IBAction func chengePhotoButton(_ sender: UIButton) {
    }
    
    @IBAction func goBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
     // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
