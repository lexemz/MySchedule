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
    unowned var delegate: TextFieldTableViewCellDelegate?

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
        placeHolder: String
    ) {
        self.indexPath = indexPath
        textField.placeholder = placeHolder
    }

    func focus() {
        textField.becomeFirstResponder()
    }
    
    func unfocus() {
        textField.resignFirstResponder()
    }
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(value: textField.text, at: indexPath)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let probableNextIndexPath = IndexPath(
            row: indexPath.row + 1,
            section: indexPath.section
        )
        delegate?.textFieldShouldReturn(
            indexPath: indexPath,
            probableNextIndexPath: probableNextIndexPath
        )
        return true
    }
}

// MARK: - SetupConstraints

extension TextFieldTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            textField.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            textField.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            textField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            )
        ])
    }
}
