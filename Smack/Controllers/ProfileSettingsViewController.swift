//
//  ProfileSettingsViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 17.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    
    

    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changePhotoButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func signOutButtonAction(_ sender: UIButton) {
        do {
                 try Auth.auth().signOut()
                     print("SignOut")
             } catch{
               
             }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30
        settings()
        

    }
    
    func settings() {
        if let photoLink = DataManager.shared.user?.userPhoto {
             userAvatar?.sd_setImage(with: URL(string: photoLink), completed: nil)
         } else{
             print("NO PHOTO")
         }
        nameTextFieldOutlet.text = DataManager.shared.user?.userName
        emailTextFieldOutlet.text = DataManager.shared.user?.email
    }
    
    
    
    
    
    
    
}

extension ProfileSettingsViewController{
     
}
