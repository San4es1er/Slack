//
//  ProfileSettingsViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 13.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        user = DataManager.shared.user

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
