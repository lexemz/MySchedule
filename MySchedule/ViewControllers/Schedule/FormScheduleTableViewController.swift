//
//  FormScheduleTableViewController.swift
//  MySchedule
//
//  Created by Igor on 25.04.2022.
//

import UIKit

enum ScheduleFormSectionsConfiguration: String, CaseIterable {
    case first
    case second
    case thrid
    case fourth
}

class FormScheduleTableViewController: UITableViewController {
    
    private let cells: [ScheduleFormSectionsConfiguration: [UITableViewCell]] = [
        .first: [],
        .second: [],
        .thrid: [],
        .fourth: []
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func configureScreen() {
        view.backgroundColor = .systemGray
        title = "Add Event"
        
        tableView.register(
            FormScheduleTableViewCell.self,
            forCellReuseIdentifier: FormScheduleTableViewCell.id
        )
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        ScheduleFormSectionsConfiguration.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = ScheduleFormSectionsConfiguration.allCases[section]
        guard let availableCells = cells[sectionKey] else { return 0 }
        return availableCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FormScheduleTableViewCell.id,
            for: indexPath
        ) as! FormScheduleTableViewCell
        
        
        return cell
    }
}
