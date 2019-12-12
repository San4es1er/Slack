//
//  UIWindow + Ext.swift
//  Smack
//
//  Created by Alex Lebedev on 12.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func showModalAuth() {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "LoginVCNavigationController")
        self.rootViewController = vc
    }
    
}
