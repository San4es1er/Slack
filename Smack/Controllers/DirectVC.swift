//
//  ChatVC.swift
//  Smack
//
//  Created by Alex Lebedev on 11.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage
import Alamofire
#warning("передалать к хуям")

class DirectVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var menuButtonOutlet: UIButton!
    @IBOutlet weak var chatTableView: UITableView!
    
    // MARK: - Property
    var db = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    var chat = [Chat]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager().getUserData { (error) in
        }
        
        chatTableView.delegate = self
        chatTableView.dataSource = self

        menuButtonOutlet.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        loadChats()
    }
    
    // MARK: - Functions
    func loadChats(){
        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        db.getDocuments { (querySnapshot, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            for doc in querySnapshot!.documents {
                self.loadPhotoAndName(for: doc) { (result) in
                    switch result {
                    case .failure(let error):
                        break
                    case .success(let result):
                        self.updateChatsData(chat: doc, data: result)
                        
                    }
                }
            }
        }
    }
    
    
    private func updateChatsData(chat: DocumentSnapshot, data: [String: Any]) {
        var massOfMes = [Message]()
         let docReference = chat.reference.collection("Messages")
           docReference.order(by: "created", descending: false).getDocuments { (sd, err) in
               for mes in sd!.documents{
                   massOfMes.append(Message(dictionary: mes.data()))
               }
            let photo = data[User.Keys.userPhoto.key] as? String
            let name = data[User.Keys.userName.key] as? String
            let users = chat.data()!["users"] as? [String]
            let chat = Chat(id: chat.documentID, users: users!, companionAvatarLink: photo, name: name, messages: massOfMes, referense: chat.reference)
               self.chat.append(chat)
            if let index = self.chat.firstIndex(where: {$0.id == chat.id}) {
                self.chat[index] = chat
            } else {
                self.chat.append(chat)
            }
               self.chatTableView.reloadData()
           }
    }
    
    private func loadPhotoAndName(for chat: DocumentSnapshot, completion: @escaping (Result<[String: Any]>) -> Void ) {
        var result: [String: Any] = [:]
        guard let users = chat.data()!["users"] as? [String],
            let id = Auth.auth().currentUser?.uid,
            let companion = users.filter({$0 != id}).first else {
            return
        }
        Firestore.firestore().collection("Users").document(companion).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = snapshot {
                result[User.Keys.userName.key] = data[User.Keys.userName.key] as? String
                result[User.Keys.userPhoto.key] = data[User.Keys.userPhoto.key] as? String
                completion(.success(result))
            }
        }
    }
    
    
    
    
}
   // MARK: - Extensions
extension DirectVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DirectCell
        cell?.setup(chat: chat[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as? ChatVC else {return}
        let nav = UINavigationController(rootViewController: vc)
        vc.setUsers(chat: chat[indexPath.row])
        nav.modalPresentationStyle = .fullScreen
        show(nav, sender: nil)
        
        
    }
}
