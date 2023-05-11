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
    
    var user: User?
    
    private let networkManager = NetworkManager.shared
    private let url = NetworkManager.shared.url

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user?.name.first
        userSurnameLabel.text = user?.name.last
        phoneLabel.text = "Phone: \(user?.phone ?? "")"
        emailLabel.text = "Email: \(user?.email ?? "")"
        countryLabel.text = "Country: \(user?.location.country ?? "")"
        cityLabel.text = "City: \(user?.location.city ?? "")"

//        networkManager.fetchImage(from: user?.picture.large) { [weak self] result in
//            switch result {
//            case .success(let imageData):
//                self?.userImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

