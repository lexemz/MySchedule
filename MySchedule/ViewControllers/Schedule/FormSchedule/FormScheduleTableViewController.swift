//
//  FormScheduleTableViewController.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum ScheduleFormConfiguration: String, CaseIterable {
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

class FormScheduleTableViewController: UITableViewController {
    
    private let headerID = "headerForFormScheduleTableViewController"
    private let sections = ScheduleFormConfiguration.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func configureScreen() {
        view.backgroundColor = .systemBackground
        title = "Add Event"
        
        tableView.register(
            FormScheduleTableViewCell.self,
            forCellReuseIdentifier: FormScheduleTableViewCell.id
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
extension FormScheduleTableViewController {
    
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
            withIdentifier: FormScheduleTableViewCell.id,
            for: indexPath
        ) as! FormScheduleTableViewCell
        
        let cellsSectionTitles = sections[indexPath.section].cellsNames
        let cellTitle = cellsSectionTitles[indexPath.row]
        
        cell.configure(title: cellTitle)
        
        if sections[indexPath.section].rawValue == "COLOR" {
            cell.setBackgroundColor(.systemPink)
            print(1)
        }
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        FormScheduleTableViewCell.height
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
