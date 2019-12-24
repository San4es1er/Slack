//
//  AppDelegate.swift
//  Smack
//
//  Created by Alex Lebedev on 09.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        if Auth.auth().currentUser != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SWRevealViewController")
            self.window?.rootViewController = vc
        }else{
            self.window?.showModalAuth()
        }
//        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
//            guard let self = self else { return }
//            if user == nil{
//                self.window?.showModalAuth()
//            }
//        }
        return true
    }
}

