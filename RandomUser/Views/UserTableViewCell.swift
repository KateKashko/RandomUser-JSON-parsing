//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSurnameLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!
    @IBOutlet weak var userPhoneLabel: UILabel!
    
    
    private let networkManager = NetworkManager.shared
    
    func configure(with user: User) {
        userNameLabel.text = user.name.first
        userSurnameLabel.text = user.name.last
        userPhoneLabel.text = user.phone
        
        networkManager.fetchImage(from: user.picture.thumbnail) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.userImageLabel.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
