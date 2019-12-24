//
//  ViewController + Ext.swift
//  Liquid
//
//  Created by Alex Lebedev on 29.11.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(message: AlertMessagers) {
        let alert = UIAlertController(title: "Ошибка", message: message.discription, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
     }

}
