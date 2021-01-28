//
//  FetchPhotoOperation.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/27/21.
//

import Foundation

class FetchPhotoOperation: ConcurrentOperation {
    
    let userImageURL: String
    var imageData: Data?
    private var task: URLSessionDataTask?
    
    init(userImageURL: String) {
        self.userImageURL = userImageURL
    }
    
    override func start() {
        state = .isExecuting
        guard let url = URL(string: userImageURL) else { return }
        
        task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = data else { return }
            self.imageData = data
            
            do { self.state = .isFinished}
        }
        task?.resume()
    }
    
    override func cancel() {
        task?.cancel()
    }
    
}
