//
//  Chat.swift
//  Smack
//
//  Created by Alex Lebedev on 11.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Chat {
    
    var users: [String]
    var companionId: String? {
        return users.filter { $0 != Auth.auth().currentUser?.uid}.first
    }
    var companionAvatarLink: String?
    
    var messages: [Message] //all messeges
    var referense: DocumentReference //Referense to the room with messeges and users
    
    var dictionary: [String: Any] {
        return [
            "users": users
        ]
    }
    
}
extension Chat {
    
    init?(dictionary: [String:Any], mes: [Message], ref: DocumentReference) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}        
        self.init(users: chatUsers, messages: mes, referense: ref)
    }
    
}
