//
//  ColorPickTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class ColorPickTableViewCell: UITableViewCell {
    // MARK: - Static properties

    static let id = "ColorPickCell"

    // MARK: - UI Elements

    private lazy var cellLabel: UILabel = {
        let label = UILabel(initialText: "Color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var colorWindow: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = .systemGray
        return view
    }()

    // MARK: - Public Properties

    var colorWindowFrame: CGRect {
        colorWindow.frame
    }

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

    func setColor(_ color: UIColor) {
        colorWindow.backgroundColor = color
    }
}

// MARK: - SetupConstraints

extension ColorPickTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            cellLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            )
        ])

        contentView.addSubview(colorWindow)
        NSLayoutConstraint.activate([
            colorWindow.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor),
            colorWindow.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
            colorWindow.heightAnchor.constraint(
                equalToConstant: 25
            ),
            colorWindow.widthAnchor.constraint(
                equalToConstant: 25
            )
        ])
    }
}
