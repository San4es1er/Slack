//
//  Firebase Managers.swift
//  Smack
//
//  Created by Alex Lebedev on 10.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

class FirebaseManager{
    let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping(Error?) -> Void ){
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
    func registration(email: String, username: String, password: String, completion: @escaping(Error?) -> Void ){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(error)
                return
            }
            self.signIn(email: email, password: password) { (error) in
                guard error == nil else{
                    completion(error)
                    return }
                createUser(email: email, username: username) { (error) in
                    guard error == nil else{
                        completion(error)
                        return
                    }
                    FirebaseManager().getUserData { (error) in
                        completion(error)
                    }
                }
            }
        }
        
        
        func createUser(email: String, username: String, completion: @escaping(Error?) -> Void){            db.collection(Collections.Users.discription).document(Auth.auth().currentUser!.uid).setData([
            User.Keys.userName.key: username,
            User.Keys.email.key: email
        ]){ error in
            completion(error)
            }
        }
    }
    
    
    
    func listenerForChats(watch: Collections, albums: @escaping (String) -> ()) {
        let albumsCollection = Firestore.firestore().collection(watch.discription)
        
        albumsCollection.addSnapshotListener { query, error in
            DispatchQueue.main.async {
                #warning("Add code after make chat cell")
                albums("CHECK")
            }
        }
    }
    
    
    
    func getUserData(completion: @escaping(Error?) -> Void){
        let uid = Auth.auth().currentUser?.uid
        db.collection("Users").document(uid!).getDocument { (documentSnapshot, error) in
            guard error == nil else{
                completion(error)
                return
            }
            guard let document = documentSnapshot else{
                completion(ResponseError.unidentified)
                return
            }
            let user = User(document: document)
            DataManager.shared.user = user
            completion(nil)
        }
    }
    
    
}

