//
//  ColorPickTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

class ColorPickTableViewCell: UITableViewCell {
    static let id = "ColorPickCell"
    
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
    var colorWindowFrame: CGRect {
        colorWindow.frame
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setColor(_ color: UIColor) {
        colorWindow.backgroundColor = color
    }
}

extension ColorPickTableViewCell {
    private func setupConstraints() {
        addSubview(cellLabel)
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        
        addSubview(colorWindow)
        NSLayoutConstraint.activate([
            colorWindow.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorWindow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            colorWindow.heightAnchor.constraint(equalToConstant: 25),
            colorWindow.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
