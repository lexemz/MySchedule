//
//  FormScheduleTableViewCell.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

class FormScheduleTableViewCell: UITableViewCell {
    static let id = "scheduleFormCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
