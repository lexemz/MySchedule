//
//  TextFieldTableViewCellDelegate.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import Foundation

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textFieldDidEndEditing(text: String, indexPath: IndexPath)
}
