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
        var companionID = chat.companionId
        var link: String?
        var message: Message
        var companion: User?
        
        db.collection("Users").document(companionID!).getDocument { (user, error) in
            guard let user = user else { return }
            companion = User(document: user)
            link = companion!.userPhoto!
            self.avatarImage.sd_setImage(with: URL(string: link!), completed: nil)
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
