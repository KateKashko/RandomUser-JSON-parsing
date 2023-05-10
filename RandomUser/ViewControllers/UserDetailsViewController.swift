//
//  ViewController.swift
//  RandomUser
//
//  Created by Kate Kashko on 9.05.2023.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSurnameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
//     var user: UserResult?
        var user: User?
    private let networkManager = NetworkManager.shared
    private let url = NetworkManager.shared.url

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure (with user: User) {
        userNameLabel.text = user.name.first
        userSurnameLabel.text = user.name.last
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        countryLabel.text = user.location.country
        countryLabel.text = user.location.city

        networkManager.fetchImage(from: user.picture.large) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.userImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

