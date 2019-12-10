//
//  ChannelVC.swift
//  Smack
//
//  Created by Alex Lebedev on 09.12.2019.
//  Copyright © 2019 Alex Lebedev. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    
    
// MARK: - Outlets
    @IBOutlet weak var channelsTableView: UITableView!
    @IBAction func prepareForUnwind(Segue: UIStoryboardSegue){}
    
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OPANA")
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        self.revealViewController()?.toggleAnimationDuration = 0.8
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
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
