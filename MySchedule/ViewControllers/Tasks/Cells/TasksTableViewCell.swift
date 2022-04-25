//
//  TasksTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import UIKit

final class TasksTableViewCell: UITableViewCell {
    // MARK: - Public Properties

    static let id = "tasksCell"
    
    var indexPath: IndexPath!
    var delegate: TasksTableViewCellDelegate!
    
    // MARK: - UI Elements

    private lazy var taskName = UILabel(
        initialText: "SOME TASK",
        textAlignment: .left
    )
    
    private lazy var taskDescription = UILabel(
        initialText: "SOME TASK DESCR",
        fontSize: 14,
        textAlignment: .left
    )
    
    private lazy var isDoneButton: UIButton = {
        let btn = UIButton()

        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "square")
        
        // FIXME: Make image insets
        if #available(iOS 15.0, *) {
            image?.withConfiguration(UIImage.SymbolConfiguration(scale: UIImage.SymbolScale.medium))

            var config = UIButton.Configuration.filled()
            config.image = image
            config.imagePadding = 10
            config.baseBackgroundColor = .clear
            config.baseForegroundColor = .label
            
            btn.configuration = config
        } else {
            btn.tintColor = .label
            btn.setBackgroundImage(image, for: .normal)
        }
        
        return btn
    }()
    
    // MARK: - Cell LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        isDoneButton.addTarget(
            self,
            action: #selector(isDoneButtonPressed),
            for: .touchUpInside
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    @objc private func isDoneButtonPressed() {
        delegate.buttonIsPressed(indexPath: indexPath)
    }
}

// MARK: - Setup Constraints

extension TasksTableViewCell {
    private func setupConstraints() {
        contentView.addSubview(isDoneButton)
        NSLayoutConstraint.activate([
            isDoneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            isDoneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            isDoneButton.heightAnchor.constraint(equalToConstant: 40),
            isDoneButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            taskName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: isDoneButton.leadingAnchor, constant: -16)
        ])
        
        addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            taskDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            taskDescription.trailingAnchor.constraint(equalTo: isDoneButton.leadingAnchor, constant: -16)
        ])
    }
}
