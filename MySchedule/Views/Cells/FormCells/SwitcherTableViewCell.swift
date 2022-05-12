//
//  SwitcherTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class SwitcherTableViewCell: UITableViewCell {
    // MARK: - Static properties

    static let id = "SwicherCell"

    // MARK: - UI Elements

    private lazy var cellLabel: UILabel = {
        let label = UILabel(initialText: "", adjustsFontSizeToFitWidth: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()

    // MARK: - Private Properties

    private var indexPath: IndexPath!
    unowned var delegate: SwitcherTableViewCellDelegate!

    // MARK: - View Lyfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        selectionStyle = .none
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
        _ indexPath: IndexPath, title: String, state: Bool) {
        self.indexPath = indexPath
        cellLabel.text = title
        switcher.isOn = state

        switcher.addTarget(
            self,
            action: #selector(switchIsToggled(state:)),
            for: .valueChanged
        )
    }

    // MARK: - Private Methods

    @objc private func switchIsToggled(state: UISwitch) {
        delegate.switchDidChangeValue(value: state.isOn, indexPath: indexPath)
    }
}

// MARK: - SetupConstraints

extension SwitcherTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            cellLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
        ])

        contentView.addSubview(switcher)
        NSLayoutConstraint.activate([
            switcher.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            switcher.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16
            ),
        ])
    }
}
