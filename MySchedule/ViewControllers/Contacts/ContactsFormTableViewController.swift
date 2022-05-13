//
//  ContactsFormTableViewController.swift
//  MySchedule
//
//  Created by Igor on 26.04.2022.
//

import UIKit

enum ContactsFormTableConfiguration: String, CaseIterable {
    case image = ""
    case name = "Name"
    case phoneAndMail = "Phone and Mail"
    
    var cellsTitles: [String] {
        switch self {
        case .image:
            return [""]
        case .name:
            return ["Name"]
        case .phoneAndMail:
            return ["Phone", "Mail"]
        }
    }
}

class ContactsFormTableViewController: UITableViewController {
    // MARK: - Private Properties

    private let sections = ContactsFormTableConfiguration.allCases
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    // MARK: - Private Methods
    
    private func configureScreen() {
        view.backgroundColor = .systemGray5
        title = "Add Contact"
        
        tableView.register(
            TextFieldTableViewCell.self,
            forCellReuseIdentifier: TextFieldTableViewCell.id
        )
        
        tableView.keyboardDismissMode = .onDrag
        let tapGesture = UITapGestureRecognizer(
            target: tableView,
            action: #selector(UIView.endEditing(_:))
        )
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
}

// MARK: - TableViewDataSource & TableViewDelegate

extension ContactsFormTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cellsTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTitle = sections[indexPath.section].cellsTitles[indexPath.row]
        
        switch indexPath {
        case [0, 0]:
            return UITableViewCell()
        case [1, 0]:
            let textfieldCell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTableViewCell.id
            ) as! TextFieldTableViewCell
            textfieldCell.configure(indexPath, placeHolder: cellTitle)
            textfieldCell.delegate = self
            return textfieldCell
        case [2,0], [2,1]:
            let textfieldCell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTableViewCell.id
            ) as! TextFieldTableViewCell
            textfieldCell.configure(indexPath, placeHolder: cellTitle)
            textfieldCell.delegate = self
            return textfieldCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - TextFieldTableViewCellDelegate

extension ContactsFormTableViewController: TextFieldTableViewCellDelegate {
    func textFieldShouldReturn(indexPath: IndexPath) {
        let nextRowIndexPath = IndexPath(
            row: indexPath.row + 1,
            section: indexPath.section
        )
        if let nextCell = tableView.cellForRow(at: nextRowIndexPath) as? TextFieldTableViewCell {
            nextCell.focus()
            return
        }
        
        let nextGroupIndexPath =  IndexPath(
            row: indexPath.row,
            section: indexPath.section + 1
        )
        if let nextCell = tableView.cellForRow(at: nextGroupIndexPath) as? TextFieldTableViewCell {
            nextCell.focus()
            return
        }
        
        let currentCell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell
        currentCell?.unfocus()
    }
    
    func textFieldDidEndEditing(value: String?, at indexPath: IndexPath) {
        Logger.debug(value)
    }
}
