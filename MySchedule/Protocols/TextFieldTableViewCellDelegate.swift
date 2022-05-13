//
//  TextFieldTableViewCellDelegate.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textFieldDidEndEditing(value: String?, at indexPath: IndexPath)
    func textFieldShouldReturn(indexPath: IndexPath)
}
