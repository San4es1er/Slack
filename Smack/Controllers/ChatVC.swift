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
    
    // MARK: - Property
    var currentUserID = Auth.auth().currentUser?.uid
    var companionID: String?
    var docReferense: DocumentReference?
    var messages = [Message]()
    var companionImageUrl: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        title = ""
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        listener()
    }
    
    // MARK: - Functions
    @objc private func cancelTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    func setUsers(chat: Chat){
        self.companionID = chat.companionId
        self.docReferense = chat.referense
        self.companionImageUrl = chat.companionAvatarLink
        self.messages = chat.messages
        self.messagesCollectionView.reloadData()
        self.messagesCollectionView.scrollToBottom()
        
    }
    
    func listener(){
        
        docReferense?.collection("Messages").order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: false, listener: { (newMessage, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            self.messages.removeAll()
            for message in newMessage!.documents{
                let msg = Message(dictionary: message.data())
                self.messages.append(msg)
            }
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom(animated: true)
        })
    }
    
}

// MARK: - Extensions
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
            avatarView.sd_setImage(with: URL(string:(DataManager.shared.user?.userPhoto)!), completed: nil)
        }else{
            avatarView.sd_setImage(with: URL(string: companionImageUrl!), completed: nil)
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}

extension ChatVC: MessageInputBarDelegate{
    
    func inputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = Message(id: nil, content: text, created: Timestamp(date: Date()), senderID: currentUserID, senderName: DataManager.shared.user?.userName)
        let data: [String: Any] = [
            "content": message.content as Any,
            "created": message.created as Any,
            "id": message.id as Any,
            "senderID": message.senderID as Any,
            "senderName": message.senderName as Any
        ]
        docReferense?.collection("Messages").addDocument(data: data)
    }
    
}
