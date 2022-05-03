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
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    private func configureScreen() {
        view.backgroundColor = .systemBackground
        title = "Add Event"
        
        tableView.register(
            HeaderForCell.self,
            forHeaderFooterViewReuseIdentifier: HeaderForCell.headerID
        )
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
        
//        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
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
        let teachersVC = TeachersViewController()
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
        sections[section].cellsInSection
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellsSectionTitles = sections[indexPath.section].cellsNames
        let cellTitle = cellsSectionTitles[indexPath.row]
        
        switch indexPath {
        case [0, 0]:
            let bageCell = tableView.dequeueReusableCell(withIdentifier: TitleWithBageTableViewCell.id) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "plus")
            return bageCell
        case [0, 1]:
            let bageCell = tableView.dequeueReusableCell(withIdentifier: TitleWithBageTableViewCell.id) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "plus")
            return bageCell
        case [2, 0]:
            let bageCell = tableView.dequeueReusableCell(withIdentifier: TitleWithBageTableViewCell.id) as! TitleWithBageTableViewCell
            bageCell.configure(title: cellTitle, bage: "chevron.right")
            return bageCell
        case [3, 0]:
            return tableView.dequeueReusableCell(withIdentifier: ColorPickTableViewCell.id) as! ColorPickTableViewCell
        case [4, 0]:
            let switchCell = tableView.dequeueReusableCell(withIdentifier: SwitcherTableViewCell.id) as! SwitcherTableViewCell
            switchCell.configure(title: cellTitle, state: true)
            return switchCell
        default:
            let textFieldCell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.id) as! TextFieldTableViewCell
            textFieldCell.configure(placeHolder: "Type \(cellTitle)")
            return textFieldCell
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        ScheduleFormTableViewCell.height
    }
    
    /*
     Расстояние headers у tableView в iOS 15.0 отличается от всех предыдущих
     поэтому выставляем примерно одинаковые отступы
     */
    // TODO: Проверить, какие отступы на iOS 14
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
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch indexPath {
        case [0, 0]:
            AlertManager.shared.showAlertWithDatePicker(onScreen: self) { _, _, stringDate in
                let dateCell = tableView.cellForRow(at: [0, 0]) as! TitleWithBageTableViewCell
                dateCell.addSecondTest(stringDate)
                tableView.deselectRow(at: [0, 0], animated: true)
            }
        case [0, 1]:
            AlertManager.shared.showAlertWithTimePicker(onScreen: self) { _, stringTime in
                let dateCell = tableView.cellForRow(at: [0, 1]) as! TitleWithBageTableViewCell
                dateCell.addSecondTest(stringTime)
                tableView.deselectRow(at: [0, 1], animated: true)
            }
        // TEACHER NAME CASE
        case [2, 0]:
            presentTeachersVC()
            tableView.deselectRow(at: [2, 0], animated: true)
        // COLOR SELECTION
        case [3, 0]:
            let cell = tableView.cellForRow(at: indexPath) as! ColorPickTableViewCell
            presentColorPicker(on: cell)
        default: Logger.debug("No action was expected")
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

// MARK: - ColorPickerDelegate

extension ScheduleFormTableViewController: ColorPickerDelegate {
    func colorPickerDidColorSelected(selectedColor: UIColor) {
        let colorCell = tableView.cellForRow(at: [3, 0]) as! ColorPickTableViewCell
        colorCell.setColor(selectedColor)
        tableView.deselectRow(at: [3, 0], animated: true)
    }
}
