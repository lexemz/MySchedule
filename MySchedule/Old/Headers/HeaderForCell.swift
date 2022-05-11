//
//  HeaderForCell.swift
//  MySchedule
//
//  Created by Igor on 27.04.2022.
//

import UIKit

class HeaderForCell: UITableViewHeaderFooterView {
    
    static let headerID = "headerForTableViewController"
    
    private lazy var headerLabel = UILabel(
        initialText: "",
        fontSize: 16,
        bold: true,
        textColor: .systemGray
    )
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupConstraints()
        contentView.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeader(with name: String) {
        headerLabel.text = name
    }
}

extension HeaderForCell {
    func setupConstraints() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
}
