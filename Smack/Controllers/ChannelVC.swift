//
//  ChannelVC.swift
//  Smack
//
//  Created by Alex Lebedev on 09.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ChannelVC: UIViewController {
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var channelsTableView: UITableView!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileButtonOutlet: UIButton!
    
    @IBAction func TESTBUTTON(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch{
          
        }
    }
    
    // MARK: - Actions
    @IBAction func profileButtonAction(_ sender: UIButton) {

    
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        self.revealViewController()?.toggleAnimationDuration = 0.8
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        profileButtonOutlet.setTitle(DataManager.shared.user?.userName, for: .normal)
        
        if let photoLink = DataManager.shared.user?.userPhoto {
            profilePhoto?.sd_setImage(with: URL(string: photoLink), completed: nil)
        } else{
            print("NO PHOTO")
        }
    }
    
    
}


extension ChannelVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "TEST \(indexPath.row)"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    
}
