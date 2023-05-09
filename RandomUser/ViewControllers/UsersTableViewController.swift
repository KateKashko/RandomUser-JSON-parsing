//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    let users: [User] = []
   private let url = NetworkManager.shared.url
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let cell = cell as? UserTableViewCell else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}
    // MARK: - Networking
    extension UsersTableViewController {
        func fetchUser() {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(UserResults.self, from: data)
                    print(user)
                } catch  {
                    print(error.localizedDescription)
                }
            }.resume()

        }
    }

