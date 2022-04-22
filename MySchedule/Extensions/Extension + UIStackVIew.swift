//
//  Extension + UIStackVIew.swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import UIKit

extension UIStackView {
    convenience init(
        arrangedSubviews: [UIView],
        asix: NSLayoutConstraint.Axis,
        spacing: CGFloat,
        distribution: UIStackView.Distribution
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
