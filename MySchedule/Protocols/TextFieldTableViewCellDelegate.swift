//
//  TextFieldTableViewCellDelegate.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import UIKit

protocol TextFieldTableViewCellDelegate: AnyObject {
    func textFieldShouldReturn(
        indexPath: IndexPath,
        probableNextIndexPath: IndexPath
    )
    func textFieldDidEndEditing(value: String?, at indexPath: IndexPath)
}
