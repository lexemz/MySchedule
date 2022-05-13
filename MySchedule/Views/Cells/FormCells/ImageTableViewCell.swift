//
//  ImageTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 13.05.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    static let id = "imageCell"
    
    private lazy var contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
}

extension ImageTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            contactImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5
            ),
            contactImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor)
        ])
        layoutIfNeeded()
    }
}
