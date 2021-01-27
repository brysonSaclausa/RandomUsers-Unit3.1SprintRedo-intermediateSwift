//
//  RandomUser.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/27/21.
//

import UIKit

class RandomUser {
    let name: String
    let email: String
    let phone: String
    let thumbnailURL: URL
    let mediumURL: URL
    
    init(email: String, phone: String, name: String, thumbnail: URL, medium: URL) {
        self.email = email
        self.phone = phone
        self.name = name
        self.thumbnailURL = thumbnail
        self.mediumURL = medium
    }
    
    convenience init(userRep: RandomUserRep) {
        self.init(email: userRep.email, phone: userRep.phone, name: userRep.name, thumbnail: URL(string: userRep.thumbnail)!, medium: URL(string: userRep.medium)!)
    }
}
