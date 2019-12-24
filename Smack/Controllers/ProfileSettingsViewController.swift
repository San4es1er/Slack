//
//  ProfileSettingsViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 17.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()


    }
    


}

extension ProfileSettingsViewController{
     func settings(){
  if let photoLink = DataManager.shared.user?.userPhoto {
             userAvatar?.sd_setImage(with: URL(string: photoLink), completed: nil)
         } else{
             print("NO PHOTO")
         }
    }
}
