//
//  UserCustomTableViewCell.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/26/21.
//

import UIKit

class UserCustomTableViewCell: UITableViewCell {
    
    var randomUser: RandomUser? {
        didSet {
            configureView()
        }
    }
    
    //MARK: - IBOUTLETS

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    func configureView() {
        guard let randomUser = randomUser else { return }
        nameLabel.text = randomUser.name
    }
    
    

}
