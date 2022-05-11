//
//  TasksFormTableViewController.swift
//  MySchedule
//
//  Created by Igor on 11.05.2022.
//

import UIKit

enum TasksFormTableConfiguration: String, CaseIterable {
    case date = "DATE"
    case titleAndDescription = "TITLE AND DESCRIPTION"
    case color = "COLOR"
    
    var cellsTitles: [String] {
        switch self {
        case .date:
            return ["Date"]
        case .titleAndDescription:
            return ["Title", "Description"]
        case .color:
            return ["Color"]
        }
    }
}

class TasksFormTableViewController: UITableViewController {
    // MARK: - Private Properties
    private let sections = TasksFormTableConfiguration.allCases
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    // MARK: - Private Methods
    
    private func configureScreen() {
        view.backgroundColor = .systemGray5
        title = "Add Task"
        
        tableView.register(
            TitleWithBageTableViewCell.self,
            forCellReuseIdentifier: TitleWithBageTableViewCell.id
        )
        tableView.register(
            TextFieldTableViewCell.self,
            forCellReuseIdentifier: TextFieldTableViewCell.id
        )
        tableView.register(
            ColorPickTableViewCell.self,
            forCellReuseIdentifier: ColorPickTableViewCell.id
        )
        
        tableView.keyboardDismissMode = .onDrag
        let tapGesture = UITapGestureRecognizer(
            target: tableView,
            action: #selector(UIView.endEditing(_:))
        )
        tableView.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func presentColorPicker(on cell: ColorPickTableViewCell) {
        let colorVC = ColorPickerViewController()
        colorVC.delegate = self
        colorVC.modalPresentationStyle = .popover
        colorVC.popoverPresentationController?.permittedArrowDirections = .down
        
        let popOverColorVC = colorVC.popoverPresentationController
        popOverColorVC?.delegate = self
        popOverColorVC?.sourceView = cell

        popOverColorVC?.sourceRect = cell.colorWindowFrame

        colorVC.preferredContentSize = CGSize(width: 220, height: 100)
        present(colorVC, animated: true)
    }
}

// MARK: - TableViewDataSource & TableViewDelegate
extension TasksFormTableViewController {
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
            let titleCell = tableView.dequeueReusableCell(
                withIdentifier: TitleWithBageTableViewCell.id
            ) as! TitleWithBageTableViewCell
            titleCell.configure(title: cellTitle, bage: "plus")
            return titleCell
        case [1, 0], [1, 1]:
            let textfieldCell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTableViewCell.id
            ) as! TextFieldTableViewCell
            textfieldCell.configure(indexPath, placeHolder: cellTitle)
            textfieldCell.delegate = self
            return textfieldCell
        case [2, 0]:
            let colorPickerCell = tableView.dequeueReusableCell(
                withIdentifier: ColorPickTableViewCell.id
            ) as! ColorPickTableViewCell
            return colorPickerCell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch indexPath {
        case [0, 0]:
            AlertManager.shared.showAlertWithDatePicker(
                onScreen: self) { _, _, stringDate in
                    let dateCell = tableView.cellForRow(at: [0, 0]) as! TitleWithBageTableViewCell
                    dateCell.setSecondText(stringDate)
                    tableView.deselectRow(at: [0, 0], animated: true)
            }
        case [2, 0]:
            let cell = tableView.cellForRow(at: indexPath) as! ColorPickTableViewCell
            presentColorPicker(on: cell)
        default:
            Logger.debug("No action was expected")
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension TasksFormTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        .none
    }
}

// MARK: - ColorPickerTableViewCellDelegate

extension TasksFormTableViewController: ColorPickerTableViewCellDelegate {
    func colorPickerDidColorSelected(selectedColor: UIColor) {
        let colorCell = tableView.cellForRow(at: [2, 0]) as! ColorPickTableViewCell
        colorCell.setColor(selectedColor)
        tableView.deselectRow(at: [2, 0], animated: true)
    }
}

// MARK: - TextFieldTableViewCellDelegate

extension TasksFormTableViewController: TextFieldTableViewCellDelegate {
    func textFieldShouldReturn(indexPath: IndexPath, probableNextIndexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell
        let nextCell = tableView.cellForRow(at: probableNextIndexPath) as? TextFieldTableViewCell
        
        if let nextCell = nextCell {
            nextCell.focus()
        } else {
            currentCell?.unfocus()
        }
    }
    
    func textFieldDidEndEditing(value: String?, at indexPath: IndexPath) {
        Logger.debug(value)
    }
}
