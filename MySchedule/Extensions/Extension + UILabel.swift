//
//  Extension + UILabel.swift
//  MySchedule
//
//  Created by Igor on 22.04.2022.
//

import UIKit

extension UILabel {
    convenience init(
        initialText: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        adjustsFontSizeToFitWidth: Bool
    ) {
        self.init()
        self.text = initialText
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
//        self.backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
    }
}
