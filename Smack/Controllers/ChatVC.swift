//
//  ChatVC.swift
//  Smack
//
//  Created by Alex Lebedev on 24.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import SDWebImage

class ChatVC: MessagesViewController {
    
    var currentUserID = Auth.auth().currentUser?.uid
    var companionID: String?
    var docReferense: DocumentReference?
    var messages = [Message]()
    var companionImageUrl: String?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        loadChat()
    }
    
    
    func setUsers(chat: Chat){
        self.companionID = chat.companionId
        self.docReferense = chat.referense
       var db = Firestore.firestore()

        db.collection("Users").document(companionID!).getDocument { (user, error) in
                guard let user = user else { return }
                var companion = User(document: user)
                self.companionImageUrl = companion.userPhoto!
            }
    }
    
    
    func loadChat(){
        docReferense?.collection("Messages").order(by: "created", descending: false).addSnapshotListener({ (messageQuery, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            for message in messageQuery!.documents{
                let msg = Message(dictionary: message.data())
                self.messages.append(msg)
                print("Data: \(msg.content ?? "No message found")")
                self.messagesCollectionView.reloadData()
                  self.messagesCollectionView.scrollToBottom(animated: true)
            }
        })
    }
    
    
    
    
}

extension ChatVC: MessagesDataSource{
    func currentSender() -> SenderType {
        return Sender(senderId: currentUserID!, displayName: DataManager.shared.user!.userName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
extension ChatVC: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId == currentUserID! {
            avatarView.sd_setImage(with: URL(string: companionImageUrl!), completed: nil)
        }
    }
    
}

