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


// MARK: - MESSAGEKITCONTROLLER
//class ChatVC: MessagesViewController {
//
//    // MARK: - Outlets
//    @IBOutlet weak var menuButtonOutlet: UIButton!
//    private var docReference: DocumentReference?
//    var messages: [Message] = []
//    var db = Firestore.firestore()
//
//    var user2Name: String?
//    var user2ImgUrl: String?
//    var user2UID: String?
//    var currentUser = Auth.auth().currentUser!
//
//
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print(currentUser.email)
//        var chatsCollectionRef = db.collection("Chats")
//        chatsCollectionRef.whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "")
//                .getDocuments { (chatQuerySnap, error) in
//                    if let error = error {
//                        print(error)
//                    } else{
//                        for value in chatQuerySnap!.documents{
//                            let users = value.data()["users"] as! [String]
//                            print(users)
//                        }
//
//
//            }
//        }
//
//
//            }
//
//
//
//
//
//
//
//}

//extension ChatVC: InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
//    func currentSender() -> SenderType {
//        <#code#>
//    }
//
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        <#code#>
//    }
//
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        <#code#>
//    }
//}






// MARK: - SWREVEALCONTROLLER

class ChatVC: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var menuButtonOutlet: UIButton!
    var db = Firestore.firestore()
    var currentUser = Auth.auth().currentUser!
    var chats = [String]()
    @IBOutlet weak var chatTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        menuButtonOutlet.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        print(currentUser.email)
        loadChats()
 
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func loadChats(){
        let chatsCollectionRef = db.collection("Chats")
         chatsCollectionRef.whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "")
             .getDocuments { (chatQuerySnap, error) in
                 if let error = error {
                     print(error)
                 } else{
                     for value in chatQuerySnap!.documents{
                         self.chats = value.data()["users"] as! [String]
                         print(self.chats)
                         self.chatTableView.reloadData()
                     }
                     
                     
                 }
         }
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = chats[indexPath.row]
        return cell
    }
    
    
}
