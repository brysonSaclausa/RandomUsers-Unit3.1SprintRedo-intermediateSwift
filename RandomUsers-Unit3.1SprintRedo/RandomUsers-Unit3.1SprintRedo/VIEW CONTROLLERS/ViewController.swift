//
//  ViewController.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/25/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var user: RandomUser?
    var userIndex: Int?
    var userController: RandomUserController?
    private let photoFetchQueue = OperationQueue()
    var fetchPhotoOperations: FetchPhotoOperation?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        photoFetchQueue.name = "com.RandomUsers.UserDetailViewController"
        setUpViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     }
    
    func setUpViews() {
        guard let user = user else { return }
        nameLabel?.text = user.name
        phoneLabel?.text = user.phone
        emailLabel?.text = user.email
        fetchCurrentImage(with: "\(user.mediumURL)")
    }
    
    func fetchCurrentImage(with url: String) {
        guard let userIndex = userIndex else { return }
        
        if let imageData = userController?.mediumImageCache.value(for: userIndex){
            imageView.image = UIImage(data: imageData)
        }
        
        let fetchPhotoOperation = FetchPhotoOperation(userImageURL: url)
        
        let storeToCache = BlockOperation {
            if let imageData = fetchPhotoOperation.imageData {
                self.userController?.mediumImageCache.cache(value: imageData, for: userIndex)
            }
        }
        
        let setImageOp = BlockOperation {
            guard let imageData = fetchPhotoOperation.imageData else { return }
            self.imageView?.image = UIImage(data: imageData)
        }
        
        storeToCache.addDependency(fetchPhotoOperation)
        setImageOp.addDependency(fetchPhotoOperation)
        
        photoFetchQueue.addOperations([fetchPhotoOperation,storeToCache], waitUntilFinished: false)
        OperationQueue.main.addOperation(setImageOp)
        fetchPhotoOperations = fetchPhotoOperation
    }


}

