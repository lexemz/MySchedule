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
        bold: Bool = false,
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
        if bold { self.font = UIFont.boldSystemFont(ofSize: 16) }
        
        translatesAutoresizingMaskIntoConstraints = false
        
//        self.backgroundColor = .red
    }
}
