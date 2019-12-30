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
    var friends = [String]()
    
    init(document: DocumentSnapshot ) {
        guard let data = document.data() else {
            print("Some problems with creating users data")
            return
        }
        
        self.userName = data[Keys.userName.key] as? String ?? "No name"
        self.email = data[Keys.email.key] as? String ?? "No email"
        self.userPhoto = data[Keys.userPhoto.key] as? String ?? "No photo"
        self.friends = data[Keys.friends.key] as? [String] ?? []
    }
    
}
extension User {
    enum Keys: String {
        case userName, email, userPhoto, friends
        
        var key: String {
            return rawValue
        }
    }

}
