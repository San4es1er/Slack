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
        view.startBluring(style: .dark)
        view.addActivityIndicator()
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let username = usernameTextField.text, !username.isEmpty else {
            self.view.stopBluring()
            showAlert(message: .emptyFields)
            return
        }
        FirebaseManager().registration(email: email, username: username, password: password, avatar: userPhoto.image) { [weak self] (error) in
            self?.view.stopBluring()
            print("ERROR", error?.localizedDescription)
            guard let error = error else {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SWRevealViewController")
                self?.present(vc, animated: true, completion: nil)
             
                return
            }
            self?.showAlert(message: .error(error))
        }
    }
    
    
    
    
    @IBAction func TESTUPLOAD(_ sender: UIButton) {
        FirebaseManager().uploadAvatar(avatar: userPhoto.image, completion: { result in
            switch result {
            case .failure(let err):
                self.showAlert(message: .error(err))
            case .success(let url):
                print("loh")
                
            }
        })
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func chengePhotoButton(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func goToAuthButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:false)
        
    }
    // MARK: - Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhoto.image = image
            
        }
        dismiss(animated: true, completion: nil)
    }
}
