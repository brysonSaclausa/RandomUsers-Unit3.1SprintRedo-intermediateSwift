//
//  UsersTableViewController.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/25/21.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var randomUserController: RandomUserController! = nil

    private let photoFetchQueue = OperationQueue()
    var thumbnailCache = Cache<Int, Data>()
    var fetchPhotoOperations: [Int: FetchPhotoOperation] = [:]
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUsers()
     }//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomUserController = RandomUserController()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }//
    
    // MARK: - Methods
    
    func fetchUsers() {
        randomUserController.fetchUsers { (error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }//
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUserController.userArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCustomTableViewCell
        
        let user = randomUserController.userArray[indexPath.row]
        cell.nameLabel.text =  user.name
        
        loadImage(forCell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    private func loadImage(forCell cell: UserCustomTableViewCell, forItemAt indexPath: IndexPath) {
        if let imageData = thumbnailCache.value(for: indexPath.row) {
            cell.userImage.image = UIImage(data: imageData)
        }
        
        let user = randomUserController.userArray[indexPath.row]
        let fetchPhotoOperation = FetchPhotoOperation(userImageURL: "\(user.thumbnailURL)")
        
        let storeToCache = BlockOperation {
            if let imageData = fetchPhotoOperation.imageData {
                self.thumbnailCache.cache(value: imageData, for: indexPath.row)
            }
        }
        
        let cellReusedCheck = BlockOperation {
            if self.tableView.indexPath(for: cell) == indexPath {
                guard let imageData = fetchPhotoOperation.imageData else { return }
                cell.userImage.image = UIImage(data: imageData)
            }
        }
        
        storeToCache.addDependency(fetchPhotoOperation)
        cellReusedCheck.addDependency(fetchPhotoOperation)
        
        photoFetchQueue.addOperations([fetchPhotoOperation, storeToCache], waitUntilFinished: false)
        OperationQueue.main.addOperation(cellReusedCheck)
        fetchPhotoOperations[indexPath.row] = fetchPhotoOperation
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserSegue" {
            guard let vc = segue.destination as? UserDetailViewController,
                  let indexpath = tableView.indexPathForSelectedRow else { return }
            let userIndex = indexpath.row
            let user = randomUserController.userArray[userIndex]
            vc.user = user
            vc.userController = randomUserController
            vc.userIndex = userIndex
        }
    }
   

}
