//
//  Extension + UIStackVIew.swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import UIKit

extension UIStackView {    
    static func vStack(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }
    
    static func hStack(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.spacing = 5
        stackView.axis = .horizontal
        return stackView
    }
}
