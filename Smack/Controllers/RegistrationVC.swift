//
//  RegistationViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 10.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    
    // MARK: - Property
    let imagePicker = UIImagePickerController()
    
    // MARK: - Actions
    @IBAction func registrationButton(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: .emptyFields)
            return
        }
        
        FirebaseManager().registration(email: email, username: username, password: password) { [weak self] (error) in
            guard let error = error else {
                return
            }
            self?.showAlert(message: .error(error))
        }
    }
    
    @IBAction func chengePhotoButton(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func goBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhoto.image = image
            
        }
        dismiss(animated: true, completion: nil)
    }
}
