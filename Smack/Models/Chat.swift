//
//  Chat.swift
//  Smack
//
//  Created by Alex Lebedev on 11.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit

struct Chat {
    
    var users: [String]
    
    var dictionary: [String: Any] {
        return [
            "users": users
        ]
    }
}

extension Chat {
    
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
    
}
