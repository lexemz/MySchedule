//
//  FormScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

class FormScheduleTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    static let id = "scheduleFormCell"
    static let height: CGFloat = 44

    // MARK: - UI Elements

    private lazy var backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var cellSwitch: UISwitch?

    // MARK: - Cell LifeCycle

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
    }

    func configure(title: String) {
        cellLabel.text = title
        backgroundViewCell.backgroundColor = .systemBackground
    }

    func setBackgroundColor(_ viewColor: UIColor) {
        backgroundViewCell.backgroundColor = viewColor
    }
    
    func enableSwitchInCell() {
        cellSwitch = UISwitch()
        cellSwitch?.isOn = true
        cellSwitch?.translatesAutoresizingMaskIntoConstraints = false
        
        cellSwitch?.addTarget(
            self,
            action: #selector(switchIsToggled),
            for: .valueChanged
        )
    }
    
    @objc private func switchIsToggled(state: UISwitch) {
        if state.isOn {
            print("switch is on")
        }
    }
}

// MARK: - Setup Constraints

extension FormScheduleTableViewCell {
    private func setupConstraints() {
        addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])

        addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 16)
        ])
        
        guard let cellSwitch = cellSwitch else { return }
        
        addSubview(cellSwitch)
        NSLayoutConstraint.activate([
            cellSwitch.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            cellSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -16)
        ])
    }
}
