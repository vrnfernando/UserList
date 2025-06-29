//
//  UserDetailViewController.swift
//  UserList
//
//  Created by Vishwa Fernando on 2025-06-29.
//

import UIKit

class UserDetailViewController: UIViewController {

    private let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = user.fullName
        setupUI()
    }

    private func setupUI() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: (view.frame.width - 150)/2, y: 100, width: 150, height: 150)
        imageView.layer.cornerRadius = 75
        view.addSubview(imageView)

        if let url = URL(string: user.picture.large) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 12
        infoStack.alignment = .center
        infoStack.frame = CGRect(x: 20, y: 280, width: view.frame.width - 40, height: 200)

        let emailLabel = UILabel()
        emailLabel.text = "Email: \(user.email)"

        let phoneLabel = UILabel()
        phoneLabel.text = "Phone: \(user.phone)"

        [emailLabel, phoneLabel].forEach {
            $0.textAlignment = .center
            infoStack.addArrangedSubview($0)
        }

        view.addSubview(infoStack)
    }
}

