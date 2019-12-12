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
       let vc: LoginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginVC")
       self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        return true
    }




}

