//
//  UsersTableViewController.swift
//  RandomUsers-Unit3.1SprintRedo
//
//  Created by BrysonSaclausa on 1/25/21.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var randomUserController: RandomUserController! = nil
//    var randomUserController = RandomUserController()
    private let photoFetchQueue = OperationQueue()
    var thumbnailCache = Cache<Int, Data>()
    
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
        cell.randomUser = user
        
        return cell
    }
    
//    private func loadImage(for cell cell: UserCustomTableViewCell, forItemAt indexPath: IndexPath) {
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
