//
//  RandomUser.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/27/21.
//

import UIKit

class Person {
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
}
