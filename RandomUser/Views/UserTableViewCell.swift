//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSurnameLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!
    
    private let networkManager = NetworkManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with user: User) {
        userNameLabel.text = user.name.first
        userSurnameLabel.text = user.name.last
        
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
