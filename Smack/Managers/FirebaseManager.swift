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
import FirebaseFirestore

#warning("передалать к хуям")
class FirebaseManager {
    
    let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping(Error?) -> Void ){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
    func registration(email: String, username: String, password: String,avatar: UIImage?, completion: @escaping(Error?) -> Void ){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(error)
                return
            }
            self.signIn(email: email, password: password) { (error) in
                guard error == nil else{
                    completion(error)
                    return }
                self.uploadAvatar(avatar: avatar) { (result) in
                    switch result {
                    case .failure(let error):
                        completion(error)
                    case .success(let url):
                        self.createUser(email: email, username: username, url: url) { (error) in
                            completion(nil)
                        }
                    }
                }
            }
        }
    }
    
    
    
    //    func listenerForChats(watch: Collections, albums: @escaping (String) -> ()) {
    //        let albumsCollection = Firestore.firestore().collection(watch.discription)
    //        albumsCollection.addSnapshotListener { query, error in
    //            DispatchQueue.main.async {
    //                #warning("Add code after make chat cell")
    //                albums("CHECK")
    //            }
    //        }
    //    }
    
    func createUser(email: String, username: String, url: String, completion: @escaping(Error?) -> Void){            db.collection(Collections.Users.discription)
        .document(Auth.auth().currentUser!.uid)
        .setData([
            User.Keys.userName.key: username,
            User.Keys.email.key: email,
            User.Keys.userPhoto.key: url
        ]){ error in
            completion(error)
        }
    }
    func getUserData(completion: @escaping(Error?) -> Void){
        let uid = Auth.auth().currentUser?.uid
        db.collection(Collections.Users.discription)
            .document(uid!)
            .getDocument { (documentSnapshot, error) in
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
    func uploadAvatar(avatar: UIImage?, completion: @escaping(Result<String>) -> Void) {
        guard let image = avatar, let data = image.jpegData(compressionQuality: 1.0) else { return }
        guard let imageName = Auth.auth().currentUser?.uid else { return }
        let imageReference = Storage.storage().reference().child("UsersAvatars").child(imageName)
        let metadata = StorageMetadata.init()
        metadata.contentType = "image/jpeg"
        imageReference.putData(data, metadata: metadata) { (metadata, error) in
            if let error = error{
                print("TEST", error.localizedDescription)
                completion(.failure(error))
                return
            }
            imageReference.downloadURL { (url, error) in
                if let error = error{
                    completion(.failure(error))
                    return
                }
                guard let url = url else{ return }
                print(url)
                completion(.success(url.absoluteString))
            }
        }
    }
    func sendMessage(user2UID: String){
        let users = [Auth.auth().currentUser?.uid, user2UID]
        let data: [String: Any] = [
            "users":users
        ]
        var mes = Message(id: "132", content: "HELLO", created: Timestamp.init(seconds: 21, nanoseconds: 12), senderID: Auth.auth().currentUser!.uid, senderName: "Alex")
        var randomID = UUID().uuidString
        
        //        db.collection(Collections.Chats.discription).document("vgvyt").collection.addDocument(data: mes.dictionary )
        
        
    }
    
    // DELETE>
    func returnFriends(id: String, completion: @escaping(String?) -> Void) {
        db.collection(Collections.Users.discription)
            .document(id)
            .getDocument { (document, error) in
                guard error == nil else{
                    completion(nil)
                    return
                }
                guard let friend = document else{
                    return
                }
                var userName = friend[User.Keys.userName.key] as? String ?? "No name"
                completion(userName)
                
        }
    }
    
    func returnModel(id: String, completion: @escaping (Result<User?>) -> Void) {
        db.collection(Collections.Users.discription)
            .document(id)
            .getDocument { (document, error) in
                guard error == nil else{
                    completion(.failure(error!))
                    return
                }
                guard let document = document else {
                    completion(.failure(ResponseError.unidentified))
                    return
                }
                let friend = User(document: document)
                completion(.success(friend))
        }
    }
    
    func addFriend(uid: String, completion: @escaping (Error?) -> Void) {
        if uid == Auth.auth().currentUser?.uid{
            completion(ResponseError.addSelf)
            
        }
        db.collection(Collections.Users.discription).document(uid).getDocument { (ds, error) in
            guard error == nil else {
                completion(error)
                return
            }
            
            if DataManager.shared.user!.friends.contains(uid) {
                 completion(ResponseError.friendAlreadyExist)
            }
         
            if ds!.exists {
                self.db.collection(Collections.Users.discription)
                    .document(Auth.auth().currentUser!.uid)
                    .updateData(["friends" : FieldValue.arrayUnion([uid])]) { (error) in
                        if let error = error {
                            completion(error)
                        }
                        completion(nil)
                }
            }
        }
    }
}

