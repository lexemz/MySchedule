//
//  FormScheduleTableViewController.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum ScheduleFormConfiguration: String, CaseIterable {
    case first
    case second
    case thrid
    case fourth
    
    static let cellsInSection: [Self: Int] = [
        .first: 1,
        .second: 2,
        .thrid: 4,
        .fourth: 1
    ]
}

class FormScheduleTableViewController: UITableViewController {
    
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
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
    }
}

// MARK: - TableViewDataSourse & TableViewDelegate methods
extension FormScheduleTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        ScheduleFormConfiguration.allCases.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let section = ScheduleFormConfiguration.allCases[section]
        guard let availableCells = ScheduleFormConfiguration.cellsInSection[section] else { return 0 }
        return availableCells
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FormScheduleTableViewCell.id,
            for: indexPath
        ) as! FormScheduleTableViewCell
        
        cell.cellLabel.text = "\(indexPath.row)"
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        FormScheduleTableViewCell.height
    }
}
