//
//  ContactsTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 12.05.2022.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cellTitle = UILabel(
        initialText: "CONTACT NAME"
    )
    
    private let phoneImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "phone.fill")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iv.widthAnchor.constraint(equalTo: iv.heightAnchor).isActive = true
        return iv
    }()
    
    private let mailImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "envelope.fill")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iv.widthAnchor.constraint(equalTo: iv.heightAnchor).isActive = true
        return iv
    }()
    
    private lazy var phoneLabel = UILabel(
        initialText: "8 800 555 35 35",
        fontSize: 14
    )

    private lazy var mailLabel = UILabel(
        initialText: "howAreYou@gmail.com",
        fontSize: 14
    )
    
    private lazy var communicationInfoStack: UIStackView = {
        let stackView = UIStackView.hStack([phoneImage, phoneLabel, mailImage, mailLabel])
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private lazy var contactInfoStack: UIStackView = {
        let stackView = UIStackView.vStack([cellTitle, communicationInfoStack])
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    static let id = "ContactsTableViewCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
}

extension ContactsTableViewCell {
    func setupConstraints() {
        contentView.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            userImage.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            userImage.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5
            ),
            userImage.widthAnchor.constraint(
                equalTo: userImage.heightAnchor
            )
        ])
        
        contentView.addSubview(contactInfoStack)
        NSLayoutConstraint.activate([
            contactInfoStack.leadingAnchor.constraint(
                equalTo: userImage.trailingAnchor,
                constant: 16
            ),
            contactInfoStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            contactInfoStack.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
        if #available(iOS 15.0, *) {
            
        } else {
            layoutIfNeeded()
        }
    }
}
