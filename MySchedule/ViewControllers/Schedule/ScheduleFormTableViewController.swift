//
//  ScheduleFormTableViewController.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum ScheduleFormTableConfiguration: String, CaseIterable {
    // Sections on TableView
    case dateAndTime = "DATE AND TIME"
    case lesson = "LESSON"
    case teacher = "TEACHER"
    case color = "COLOR"
    case period = "PERIOD"
    
    var cellsInSection: Int {
        switch self {
        case .dateAndTime:
            return 2
        case .lesson:
            return 3
        case .teacher:
            return 1
        case .color:
            return 1
        case .period:
            return 1
        }
    }
    
    var cellsNames: [String] {
        switch self {
        case .dateAndTime:
            return ["Date", "Time"]
        case .lesson:
            return ["Name", "Type", "Building", "Audience"]
        case .teacher:
            return ["Teacher Name"]
        case .color:
            return [""]
        case .period:
            return ["Repeat every 7 days"]
        }
    }
}

class ScheduleFormTableViewController: UITableViewController {

    private let sections = ScheduleFormTableConfiguration.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func configureScreen() {
        view.backgroundColor = .systemBackground
        title = "Add Event"
        
        tableView.register(
            ScheduleFormTableViewCell.self,
            forCellReuseIdentifier: ScheduleFormTableViewCell.id
        )
        tableView.register(
            HeaderForCell.self,
            forHeaderFooterViewReuseIdentifier: HeaderForCell.headerID
        )
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
    }
}

// MARK: - TableViewDataSourse & TableViewDelegate methods

extension ScheduleFormTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections[section].cellsInSection
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ScheduleFormTableViewCell.id,
            for: indexPath
        ) as! ScheduleFormTableViewCell
        
        let cellsSectionTitles = sections[indexPath.section].cellsNames
        let cellTitle = cellsSectionTitles[indexPath.row]
        
        switch indexPath {
        case [3, 0]:
            cell.configure(title: cellTitle, cellType: .colorPicker)
        case [4, 0]:
            cell.configure(title: cellTitle, cellType: .switcher)
        default:
            cell.configure(title: cellTitle, cellType: .text)
        }
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        ScheduleFormTableViewCell.height
    }
    
    // Расстояние у tableview в iOS 15.0 отличается от всех предыдущих
    override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        if #available(iOS 14.0, *) {
            return 25
        } else {
            return 45
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderForCell.headerID
        ) as! HeaderForCell
        
        let headerTitle = sections[section].rawValue
        
        header.configureHeader(with: headerTitle)

        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ScheduleFormTableViewCell
        let alertManager = AlertManager.shared
        
        switch indexPath {
        // DATA AND TIME CASES
        case [0, 0]:
            alertManager.showAlertWithDatePicker(onScreen: self) { _, _, stringDate in
                cell.setUserLabel(stringDate)
            }
        case [0, 1]:
            alertManager.showAlertWithTimePicker(onScreen: self) { _, stringTime in
                cell.setUserLabel(stringTime)
            }
        // NAME, TYPE, BUILDUNG CASES
        case [1, 0]:
            alertManager.showAlertWithTextField(
                onScreen: self,
                title: "Event Name"
            ) { text in
                cell.setUserLabel(text)
            }
        case [1, 1]:
            alertManager.showAlertWithTextField(
                onScreen: self,
                title: "Event Type"
            ) { text in
                cell.setUserLabel(text)
            }
        case [1, 2]:
            alertManager.showAlertWithTextField(
                onScreen: self,
                title: "Event Position"
            ) { text in
                cell.setUserLabel(text)
            }
        // TEACHER NAME CASE
        case [2, 0]:
            let teachersVC = TeachersViewController()
            let teachersNC = UINavigationController(rootViewController: teachersVC)
            present(teachersNC, animated: true)
        // COLOR SELECTION
        case [3, 0]:
            let colorVC = ColorPickerViewController()
            let colorNC = UINavigationController(rootViewController: colorVC)
            present(colorNC, animated: true)
        case [4, 0]: break // TODO: fill
        default: print("Error")
        }
    }
}
