//
//  UserRepresentation.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/27/21.
//

import Foundation

struct UserResults: Codable {
    let results: [PersonRep]
}

struct PersonRep: Codable {
    var phone: String
    var email: String
    
    var name: String

    var thumbnail: String
    var medium: String
    
    enum RandomUserTopLevelCodingKeys: String, CodingKey {
        case name
        case email
        case phone
        case picture

        enum NameKeys: String, CodingKey {
            case title
            case first
            case last

        }

        enum PictureKeys: String, CodingKey {
            case large
            case medium
            case thumbnail
        }

    }
    
    init(from decoder: Decoder) throws {
        //go to the JSON an look for these keys
        let container  = try decoder.container(keyedBy: RandomUserTopLevelCodingKeys.self)

        phone = try container.decode(String.self, forKey: .phone)
        email = try container.decode(String.self, forKey: .email)

        let nameContainer = try container.nestedContainer(keyedBy: RandomUserTopLevelCodingKeys.NameKeys.self, forKey: .name)
        let title = try nameContainer.decode(String.self, forKey: .title)
        let first = try nameContainer.decode(String.self, forKey: .first)
        let last = try nameContainer.decode(String.self, forKey: .last)

        name = "\(title). \(first) \(last)"
        
        let pictureContainer = try container.nestedContainer(keyedBy: RandomUserTopLevelCodingKeys.PictureKeys.self, forKey: .picture)
        
        thumbnail = try pictureContainer.decode(String.self, forKey: .thumbnail)
        medium = try pictureContainer.decode(String.self, forKey: .medium)
     }
}

