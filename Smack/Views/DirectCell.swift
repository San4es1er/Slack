//
//  DirectCell.swift
//  Smack
//
//  Created by Alex Lebedev on 24.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class DirectCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var messageDateLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    // MARK: - Property
    var db = Firestore.firestore()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(chat: Chat){
        let companionID = chat.companionId
        var link: String?
        var message: Message = chat.messages.last!
        var companion: User?
        
        db.collection("Users").document(companionID!).getDocument { (user, error) in
            guard let user = user else { return }
            companion = User(document: user)
            link = companion!.userPhoto!
            self.avatarImage.sd_setImage(with: URL(string: link!), completed: nil)
               
        }
        self.senderNameLabel.text = message.senderName
        self.messageBodyLabel.text = message.content
        var dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        
        self.messageDateLabel.text = "12:42"
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
