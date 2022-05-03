//
//  SwitcherTableViewCellDelegate.swift
//  MySchedule
//
//  Created by Igor on 03.05.2022.
//

import Foundation

protocol SwitcherTableViewCellDelegate: AnyObject {
    func switchDidChangeValue(value: Bool, indexPath: IndexPath)
}
