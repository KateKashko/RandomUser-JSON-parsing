//
//  UsersTableViewController.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
//    var results: [User] = []
    private var users: UserResult?
    private let url = URL(string: "https://randomuser.me/api/?format=json&results=20")!
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
  fetchUser()
//        tableView.rowHeight = 70
        
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

//    func fetchUser() {
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data else {
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                self?.results = try decoder.decode([User].self, from: data)
//                DispatchQueue.main.async {
//                    self?.tableView.reloadData()
//                }
//            } catch  {
//                print(error.localizedDescription)
//            }
//        }.resume()
//
//    }

}

