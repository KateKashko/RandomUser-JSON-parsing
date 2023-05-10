//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    var results: [User] = []
    
   private let url = NetworkManager.shared.url
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let cell = cell as? UserTableViewCell else { return UITableViewCell() }
        let user = results[indexPath.row]
        cell.configure(with: user)
        return cell
    }
}
    // MARK: - Networking
extension UsersTableViewController {
    
    func fetchUser() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                self?.results = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}

