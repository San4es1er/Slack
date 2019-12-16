//
//  Constants.swift
//  Smack
//
//  Created by Alex Lebedev on 10.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation

//ViewControllersSegueID

let TO_REGISTRATION_VC = "toRegistrationVC"
let TO_LOGIN_VC = "toLoginVC"

//Enums

enum AlertMessagers {
    case emptyFields
    case error(_ error: Error)
    
    var discription: String{
        switch self {
        case .emptyFields:
            return "Заполните все поля!"
        case .error(let error):
            return error.localizedDescription
        }
    }
    
    
}

enum Collections: String {
    case Chats
    case Users
    
    var discription: String{
        return rawValue
    }
}

enum ResponseError: LocalizedError {
    case internetNotAvailable
    case unidentified
    
    var errorDescription: String? {
        switch self {
        case .internetNotAvailable:
            return "Internet not available"
        case .unidentified:
            return "Unidentified error"
        }
        
    }
}
