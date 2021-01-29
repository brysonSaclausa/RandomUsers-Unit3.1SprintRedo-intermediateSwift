//
//  RandomUserController.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/27/21.
//

import Foundation

class RandomUserController {
    var userArray = [RandomUser]()
    let baseURL = URL(string: "https://randomuser.me/api/?results=100")!
    var mediumImageCache = Cache<Int, Data>()
    
    func fetchUsers(completion: @escaping (Error?) -> ()) {
        URLSession.shared.dataTask(with: baseURL) {data, _, error in
            if let error = error {
                completion(error)
            }
            
            guard let data = data else {
                completion(NSError(domain: "Fetch error", code: -1, userInfo: nil))
                return
            }
                
            do {
                let results = try JSONDecoder().decode(UserResults.self, from: data)
                let userRepList = results.results
                
                for userRep in userRepList {
                    let user = RandomUser(userRep: userRep)
                    self.userArray.append(user)
                    
                }
                completion(nil)
            } catch {
                completion(error)
            }
        }
        .resume()
    }
    
    
}
