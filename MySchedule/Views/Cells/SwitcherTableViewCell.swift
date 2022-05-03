//
//  SwitcherTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class SwitcherTableViewCell: UITableViewCell {
    static let id = "SwicherCell"
    
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
    
    func configure(title: String, state: Bool) {
        cellLabel.text = title
        switcher.isOn = state
        
        switcher.addTarget(
            self,
            action: #selector(switchIsToggled(state:)),
            for: .valueChanged
        )
    }
    
    @objc private func switchIsToggled(state: UISwitch) {
        if state.isOn {
            Logger.debug("Switch om cell is on")
        }
    }
}

extension SwitcherTableViewCell {
    private func setupConstraints() {
        addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        
        addSubview(switcher)
        NSLayoutConstraint.activate([
            switcher.centerYAnchor.constraint(equalTo: centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
