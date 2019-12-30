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
import QRCodeReader

class MenuVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var channelsTableView: UITableView!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileButtonOutlet: UIButton!
    
    // MARK: - Property
    var friends = [User]()
    
    // MARK: - Actions
    @IBAction func profileButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileSettingsViewController")
        show(vc, sender: nil)
    }
    @IBAction func readQRButtonAction(_ sender: UIButton) {
        present(readerVC, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setFriend()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        self.revealViewController()?.toggleAnimationDuration = 0.8
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        readerVC.delegate = self
        profileButtonOutlet.setTitle(DataManager.shared.user?.userName, for: .normal)
        if let photoLink = DataManager.shared.user?.userPhoto {
            profilePhoto?.sd_setImage(with: URL(string: photoLink), completed: nil)
        } else{
            print("NO PHOTO")
        }
    }
    
    // MARK: - Functions
    func setFriend() {
        self.friends.removeAll()
        for id in DataManager.shared.user!.friends{
            FirebaseManager().returnModel(id: id) { (result) in
                switch result{
                case .failure(let error):
                    print(error)
                    return
                case .success(let model):
                    self.friends.append(model!)
                }
                self.channelsTableView.reloadData()
            }
        }
    }
    
    var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    
}

// MARK: - Extensions
extension MenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].userName
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}





extension MenuVC: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
 
        FirebaseManager().addFriend(uid: result.value) { (error) in
            guard error == nil else{
                self.showAlert(message: .error(error!))
                return
            }
            FirebaseManager().returnModel(id: result.value) { (result) in
                switch result{
                case .success(let model):
                    self.friends.append(model!)
                    self.channelsTableView.reloadData()
                case .failure(let error):
                    self.showAlert(message: .error(error))
                }
            }
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        
    }
}
