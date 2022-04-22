//
//  ScheduleTableVIewCell.swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    private lazy var lessonName = UILabel(
        initialText: "LESSON NAME",
        textColor: .label,
        textAlignment: .left,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var teacherName = UILabel(
        initialText: "TEACHER NAME",
        textColor: .label,
        textAlignment: .right,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var lessonTime = UILabel(
        initialText: "X:XX",
        textColor: .label,
        textAlignment: .left,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var lessonType = UILabel(
        initialText: "LESSON TYPE",
        textColor: .label,
        textAlignment: .right,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var buildingInfo = UILabel(
        initialText: "BUILDING LABEL",
        textColor: .label,
        textAlignment: .right,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var audienceИumber = UILabel(
        initialText: "AUDIENCE ИUMB",
        textColor: .label,
        textAlignment: .right,
        adjustsFontSizeToFitWidth: true
    )
    
    private lazy var cellIcon: UIImageView = {
        let image = UIImage(systemName: "book.circle")
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var topStackView = UIStackView(
        arrangedSubviews: [lessonName, teacherName],
        asix: .horizontal,
        spacing: 10,
        distribution: .fillEqually
    )
    
    private lazy var bottomStackView = UIStackView(
        arrangedSubviews: [lessonType, buildingInfo, audienceИumber],
        asix: .horizontal,
        spacing: 10,
        distribution: .fillEqually
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstaints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaints() {
        addSubview(cellIcon)
        NSLayoutConstraint.activate([
            cellIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cellIcon.heightAnchor.constraint(equalToConstant: 25),
            cellIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: cellIcon.trailingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lessonTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            lessonTime.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 10),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func chahgeIconColor(_ color: UIColor) {
        cellIcon.tintColor = color
    }
}
