//
//  TitleWithBageTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class TitleWithBageTableViewCell: UITableViewCell {
    // MARK: - Static Properties

    static let id = "TitleWithBageCell"
    
    // MARK: - UI Elements

    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - View Lyfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Public Methods
    
    func configure(title: String, bage: String) {
        cellLabel.text = title
        setupBage(bage)
    }
    
    func setSecondText(_ text: String) {
        userDataLabel.text = text
    }
    
    // MARK: - Private Methods

    private func setupBage(_ name: String) {
        let symbolImage = UIImage(systemName: name)?.withTintColor(.systemGray)
        let symbolTextAttachment = NSTextAttachment()
        symbolTextAttachment.image = symbolImage
        let attributexText = NSMutableAttributedString()
        attributexText.append(NSAttributedString(attachment: symbolTextAttachment))
        
        userDataLabel.attributedText = attributexText
    }
}

// MARK: - SetupConstraints

extension TitleWithBageTableViewCell {
    private func setupConstraints() {
        addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        addSubview(userDataLabel)
        NSLayoutConstraint.activate([
            userDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
