//
//  AddScheduleEventTableConfiguration.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum AddScheduleEventTableConfiguration: String, CaseIterable {
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

class AddScheduleEventTableViewController: UITableViewController {
    
    private let headerID = "headerForFormScheduleTableViewController"
    private let sections = AddScheduleEventTableConfiguration.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func configureScreen() {
        view.backgroundColor = .systemBackground
        title = "Add Event"
        
        tableView.register(
            AddEventScheduleTableViewCell.self,
            forCellReuseIdentifier: AddEventScheduleTableViewCell.id
        )
        tableView.register(
            UITableViewHeaderFooterView.self,
            forHeaderFooterViewReuseIdentifier: headerID
        )
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
    }
}

// MARK: - TableViewDataSourse & TableViewDelegate methods
extension AddScheduleEventTableViewController {
    
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
            withIdentifier: AddEventScheduleTableViewCell.id,
            for: indexPath
        ) as! AddEventScheduleTableViewCell
        
        let cellsSectionTitles = sections[indexPath.section].cellsNames
        let cellTitle = cellsSectionTitles[indexPath.row]
        
        cell.configure(title: cellTitle)
        
        if indexPath.section == 3 {
            cell.setBackgroundColor(.systemPink)
        }
        
        if indexPath.section == 4 {
            cell.enableSwitchInCell()
        }
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        AddEventScheduleTableViewCell.height
    }
    
    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: headerID
        )
        
        let headerText = sections[section].rawValue
        
        if #available(iOS 14.0, *) {
            var content = header?.defaultContentConfiguration()
            content?.text = headerText
            
            header?.contentConfiguration = content
        } else {
            header?.textLabel?.text = headerText
        }

        return header
    }
}
