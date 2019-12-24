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
    
    
    func loadChats(){
        let db = Firestore.firestore().collection("Chats").whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        db.getDocuments { (querySnapshot, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            for doc in querySnapshot!.documents{
                var massOfMes = [Message]()
                let docReference = doc.reference.collection("Messages")
                docReference.order(by: "created", descending: false).getDocuments { (sd, err) in
                    for mes in sd!.documents{
                        massOfMes.append(Message(dictionary: mes.data()))
                    }
                    let dialog = Chat(dictionary: doc.data(), mes: massOfMes, ref: doc.reference)
                    self.chat.append(dialog!)
                    print("NOW")
                    print(dialog?.users)
                    print(dialog?.messages)
                    self.chatTableView.reloadData()
                }
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
}
