//
//  TextFieldTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    static let id = "TextFieldCell"
    
    private lazy var textFiled: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configure(placeHolder: String) {
        textFiled.placeholder = placeHolder
    }
}

extension TextFieldTableViewCell {
    private func setupConstraints() {
        addSubview(textFiled)
        NSLayoutConstraint.activate([
//            textFiled.centerYAnchor.constraint(equalTo: centerYAnchor),
            textFiled.topAnchor.constraint(equalTo: topAnchor),
            textFiled.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFiled.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textFiled.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
