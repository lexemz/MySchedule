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
        fontSize: CGFloat = 16,
        textColor: UIColor = .label,
        textAlignment: NSTextAlignment = .left,
        adjustsFontSizeToFitWidth: Bool = true,
        numberOfLines: Int = 1
    ) {
        self.init()
        self.text = initialText
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.font = font.withSize(fontSize)
        self.numberOfLines = numberOfLines
        
        translatesAutoresizingMaskIntoConstraints = false
        
//        self.backgroundColor = .red
    }
}
