//
//  TextFieldTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    // MARK: - Static properties

    static let id = "TextFieldCell"

    // MARK: - UI Elements

    private lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private var indexPath: IndexPath!
    private unowned var delegate: TextFieldTableViewCellDelegate!

    // MARK: - View Lyfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        selectionStyle = .none
        textField.delegate = self
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

    func configure(
        _ indexPath: IndexPath,
        placeHolder: String,
        delegate: TextFieldTableViewCellDelegate
    ) {
        self.indexPath = indexPath
        self.delegate = delegate
        textField.placeholder = placeHolder
    }
}

// MARK: - SetupConstraints

extension TextFieldTableViewCell {
    private func setupConstraints() {
        addSubview(textField)
        NSLayoutConstraint.activate([
            //            textFiled.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.textFieldDidEndEditing(text: textField.text!, indexPath: indexPath)
    }
}
