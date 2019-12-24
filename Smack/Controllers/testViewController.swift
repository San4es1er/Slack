//
//  testViewController.swift
//  Smack
//
//  Created by Alex Lebedev on 20.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import Firebase
class testViewController: UIViewController {
    @IBAction func testSendButton(_ sender: UIButton) {
        FirebaseManager().sendMessage(user2UID: "H7OsUsajnBRNtSfPe4wM9HpRdSE3")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager().getUserData { (error) in
            print("-------------User-------------")
            print(Auth.auth().currentUser?.uid)
            print(Auth.auth().currentUser?.email)
            
            for value in DataManager.shared.user!.friends{
                print(value)
            }
        }
        
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
