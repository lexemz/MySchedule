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
    
    var cellsTitles: [String] {
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
    // MARK: - Private Properties

    private let sections = ScheduleFormTableConfiguration.allCases
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    // MARK: - Private Methods

    private func configureScreen() {
        view.backgroundColor = .systemGray5
        title = "Add Event"
        
        tableView.register(
            ColorPickTableViewCell.self,
            forCellReuseIdentifier: ColorPickTableViewCell.id
        )
        tableView.register(
            SwitcherTableViewCell.self,
            forCellReuseIdentifier: SwitcherTableViewCell.id
        )
        tableView.register(
            TextFieldTableViewCell.self,
            forCellReuseIdentifier: TextFieldTableViewCell.id
        )
        tableView.register(
            TitleWithBageTableViewCell.self,
            forCellReuseIdentifier: TitleWithBageTableViewCell.id
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
//        popOverColorVC?.sourceRect = CGRect(
//            x: cell.bounds.midX,
//            y: cell.bounds.minY,
//            width: 0,
//            height: 0
//        )
        
        // 220 220
        colorVC.preferredContentSize = CGSize(width: 220, height: 100)
        present(colorVC, animated: true)
    }
    
    private func presentTeachersVC() {
        let teachersVC = ContactsListViewController()
        let teachersNC = UINavigationController(rootViewController: teachersVC)
        present(teachersNC, animated: true)
    }
}

// MARK: - TableViewDataSourse & TableViewDelegate

extension ScheduleFormTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        sections[section].cellsTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].rawValue
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellsSectionTitles = sections[indexPath.section].cellsTitles
        let cellTitle = cellsSectionTitles[indexPath.row]
        
        switch indexPath {
        case [0, 0]:
            let bageCell = tableView.dequeueReusableCell(
                withIdentifier: TitleWithBageTableViewCell.id
            ) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "plus")
            return bageCell
        case [0, 1]:
            let bageCell = tableView.dequeueReusableCell(
                withIdentifier: TitleWithBageTableViewCell.id
            ) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "plus")
            return bageCell
        case [1, 0], [1, 1], [1, 2], [1, 3]:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTableViewCell.id
            ) as! TextFieldTableViewCell
            
            cell.configure(
                indexPath,
                placeHolder: "\(cellTitle)"
            )
            cell.delegate = self
            
            return cell
        case [2, 0]:
            let bageCell = tableView.dequeueReusableCell(
                withIdentifier: TitleWithBageTableViewCell.id
            ) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "chevron.right")
            return bageCell
        case [3, 0]:
            return tableView.dequeueReusableCell(
                withIdentifier: ColorPickTableViewCell.id
            ) as! ColorPickTableViewCell
        case [4, 0]:
            let switchCell = tableView.dequeueReusableCell(
                withIdentifier: SwitcherTableViewCell.id
            ) as! SwitcherTableViewCell
            switchCell.configure(
                [4, 0],
                title: cellTitle,
                state: true
            )
            switchCell.delegate = self
            return switchCell
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
            AlertManager.shared.showAlertWithDatePicker(onScreen: self) { _, _, stringDate in
                let dateCell = tableView.cellForRow(at: [0, 0]) as! TitleWithBageTableViewCell
                dateCell.setSecondText(stringDate)
            }
            tableView.deselectRow(at: [0, 0], animated: true)
        case [0, 1]:
            AlertManager.shared.showAlertWithTimePicker(onScreen: self) { _, stringTime in
                let dateCell = tableView.cellForRow(at: [0, 1]) as! TitleWithBageTableViewCell
                dateCell.setSecondText(stringTime)
            }
            tableView.deselectRow(at: [0, 1], animated: true)
        // TEACHER NAME CASE
        case [2, 0]:
            presentTeachersVC()
            tableView.deselectRow(at: [2, 0], animated: true)
        // COLOR SELECTION
        case [3, 0]:
            let cell = tableView.cellForRow(at: indexPath) as! ColorPickTableViewCell
            presentColorPicker(on: cell)
        default:
            Logger.debug("No action was expected")
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension ScheduleFormTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController
    ) -> UIModalPresentationStyle {
        .none
    }
}

// MARK: - ColorPickerTableViewCellDelegate

extension ScheduleFormTableViewController: ColorPickerTableViewCellDelegate {
    func colorPickerDidColorSelected(selectedColor: UIColor) {
        let colorCell = tableView.cellForRow(at: [3, 0]) as! ColorPickTableViewCell
        colorCell.setColor(selectedColor)
        tableView.deselectRow(at: [3, 0], animated: true)
    }
}

// MARK: - TextFieldTableViewCellDelegate

extension ScheduleFormTableViewController: TextFieldTableViewCellDelegate {
    func textFieldDidEndEditing(value: String?, at indexPath: IndexPath) {
        Logger.debug(value)
    }
    
    func textFieldShouldReturn(indexPath: IndexPath) {
        let probableNextIndexPath = IndexPath(
            row: indexPath.row + 1,
            section: indexPath.section
        )
        
        let currentCell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell
        let nextCell = tableView.cellForRow(at: probableNextIndexPath) as? TextFieldTableViewCell
        
        if let nextCell = nextCell {
            nextCell.focus()
        } else {
            currentCell?.unfocus()
        }
    }
}

// MARK: - SwitcherTableViewCellDelegate

extension ScheduleFormTableViewController: SwitcherTableViewCellDelegate {
    func switchDidChangeValue(value: Bool, indexPath: IndexPath) {
        Logger.debug(value)
        Logger.debug(indexPath)
    }
}
