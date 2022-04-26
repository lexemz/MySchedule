//
//  ScheduleFormTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum ScheduleFormCellType {
    case text
    case switcher
    case colorPicker
}

class ScheduleFormTableViewCell: UITableViewCell {
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
    
    private lazy var userDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private var cellSwitch: UISwitch?

    // MARK: - Cell LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if #available(iOS 14.0, *) {
            backgroundColor = .clear
        } else {
            backgroundColor = UIColor(
                red: 50.0/255.0,
                green: 50.0/255.0,
                blue: 52.0/255.0,
                alpha: 1.0
            )
        }
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
    
    // MARK: - Publick methods

    func configure(title: String, cellType: ScheduleFormCellType) {
        cellLabel.text = title
        backgroundViewCell.backgroundColor = .systemBackground
        
        switch cellType {
        case .text:
            enableCheckmarkInCell()
        case .switcher:
            enableSwitchInCell()
        case .colorPicker:
            setBackgroundColor(.systemBrown)
        }
    }
    
    func setUserLabel(_ string: String) {
        userDataLabel.text = string
    }
    
    // MARK: - Private methods

    private func setBackgroundColor(_ viewColor: UIColor) {
        backgroundViewCell.backgroundColor = viewColor
    }

    private func enableSwitchInCell() {
        cellSwitch = UISwitch()
        cellSwitch?.isOn = true
        cellSwitch?.translatesAutoresizingMaskIntoConstraints = false
        
        cellSwitch?.addTarget(
            self,
            action: #selector(switchIsToggled),
            for: .valueChanged
        )
    }
    
    private func enableCheckmarkInCell() {
        let symbolImage = UIImage(systemName: "plus")?.withTintColor(.systemGray)
        let symbolTextAttachment = NSTextAttachment()
        symbolTextAttachment.image = symbolImage
        let attributexText = NSMutableAttributedString()
        attributexText.append(NSAttributedString(attachment: symbolTextAttachment))
        
        userDataLabel.attributedText = attributexText
    }
    
    @objc private func switchIsToggled(state: UISwitch) {
        if state.isOn {
            print("switch is on")
        }
    }
}

// MARK: - Setup Constraints

extension ScheduleFormTableViewCell {
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
        
        addSubview(userDataLabel)
        NSLayoutConstraint.activate([
            userDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userDataLabel.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -16)
        ])
        
        guard let cellSwitch = cellSwitch else { return }
        
        userDataLabel.isHidden = true
        addSubview(cellSwitch)
        NSLayoutConstraint.activate([
            cellSwitch.centerYAnchor.constraint(equalTo: backgroundViewCell.centerYAnchor),
            cellSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -16)
        ])
    }
}
