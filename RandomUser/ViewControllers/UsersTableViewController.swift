//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    private var users: UserResult?
    private let networkManager = NetworkManager.shared
    private let url = NetworkManager.shared.url
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let cell = cell as? UserTableViewCell else { return UITableViewCell() }
        let user = users?.results[indexPath.row]
        cell.configure(with: user!)
        return cell
    }
}
    // MARK: - Networking
extension UsersTableViewController {
    private func fetchUser() {
        networkManager.fetchUser(from: url) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

