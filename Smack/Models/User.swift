//
//  User.swift
//  Smack
//
//  Created by Alex Lebedev on 12.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import Firebase

struct User {
    var userName: String!
    var email: String!
    var userPhoto: String!
    
    init(document: DocumentSnapshot ) {
        let data = document.data()
        print(data?["userName"] as? String)
        print("UUUUUUP")
        self.userName = data?["userName"] as? String ?? "No name"
        self.email = data?["email"] as? String ?? "No email"
        self.userPhoto = data?["userPhoto"] as? String ?? "No photo"
    }
}

