//
//  Message.swift
//  Smack
//
//  Created by Alex Lebedev on 11.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import MessageKit

struct Message {
    
    var id: String!
    var content: String!
    var created: Timestamp!
    var senderID: String!
    var senderName: String!
    
    var dictionary: [String: Any] {
        
        return [
            "id": id,
            "content": content,
            "created": created,
            "senderID": senderID,
            "senderName":senderName]
        
    }
}

extension Message {
    init(dictionary: [String: Any]) {
            self.id = dictionary["id"] as? String ?? ""
            self.content = dictionary["content"] as? String ?? ""
            self.created = dictionary["created"] as? Timestamp
            self.senderID = dictionary["senderID"] as? String ?? ""
            self.senderName = dictionary["senderName"] as? String ?? ""
           
        

        
    }
}

extension Message: MessageType {
    
    var sender: SenderType {
        return Sender(id: senderID, displayName: senderName)
        
    }
    
    var messageId: String {
        return id
    }
    
    var sentDate: Date {
        return created.dateValue()
    }
    
    var kind: MessageKind {
        return  .text(content)
    }
}
