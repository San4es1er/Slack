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
    // MARK: - ???????????????????????????????????????????????????????????????
//    // Data in memory
//    let data = Data()
//
//    // Create a reference to the file you want to upload
//    let riversRef = storageRef.child("images/rivers.jpg")
//
//    // Upload the file to the path "images/rivers.jpg"
//    let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//        guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//        }
//        // Metadata contains file metadata such as size, content-type.
//        let size = metadata.size
//        // You can also access to download URL after upload.
//        riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//                // Uh-oh, an error occurred!
//                return
//            }
//        }
//    }
    // MARK: - ???????????????????????????????????????????????????????????????
}

