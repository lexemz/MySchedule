//
//  ScheduleListViewController.swift
//  MySchedule
//
//  Created by Igor on 19.04.2022.
//

import FSCalendar
import UIKit

final class ScheduleListViewController: UIViewController {
    // MARK: - Constraints

    private var calendarHeightConstraint: NSLayoutConstraint!
    
    // MARK: - UI Elements

    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.scope = .week
        calendar.customCalendarAppearance()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    private lazy var expandCalendarButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Expand Calendar", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.titleLabel?.minimumScaleFactor = 0.5
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScreen()
    }
    
    // MARK: - Private Methods
    
    private func configureScreen() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Schedule"
        
        calendar.dataSource = self
        calendar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ScheduleTableViewCell.self,
            forCellReuseIdentifier: ScheduleTableViewCell.id
        )
        
        expandCalendarButton.addTarget(
            self,
            action: #selector(expandCalendarButtonPressed),
            for: .touchUpInside
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        setConstaints()
        configureExpandCalendarSwipeAction()
    }
    
    @objc private func expandCalendarButtonPressed() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            expandCalendarButton.setTitle("Collapse Calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            expandCalendarButton.setTitle("Expand Calendar", for: .normal)
        }
    }
    
    @objc private func addButtonTapped() {
        let formVC = ScheduleFormTableViewController(style: .insetGrouped)
        let formNavigationVC = UINavigationController(rootViewController: formVC)
        present(formNavigationVC, animated: true)
    }
    
    // MARK: SwipeGestureRecognizer

    private func configureExpandCalendarSwipeAction() {
        let swipeUp = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipe)
        )
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipe)
        )
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up where calendar.scope == .month: expandCalendarButtonPressed()
        case .down where calendar.scope == .week: expandCalendarButtonPressed()
        default: break
        }
    }
}

// MARK: - TableViewDelegate and TableViewDataSource

extension ScheduleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        5
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ScheduleTableViewCell.id,
            for: indexPath
        ) as! ScheduleTableViewCell
        
        switch indexPath.row {
        case 0: cell.chahgeIconColor(.systemBlue)
        case 1: cell.chahgeIconColor(.systemOrange)
        default: cell.chahgeIconColor(.systemGray)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        75
    }
}

// MARK: - FSCalendarDelegate and FSCalendarDataSource

extension ScheduleListViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(
        _ calendar: FSCalendar,
        boundingRectWillChange bounds: CGRect,
        animated: Bool
    ) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(
        _ calendar: FSCalendar,
        didSelect date: Date,
        at monthPosition: FSCalendarMonthPosition
    ) {
        Logger.debug(date)
    }
}

// MARK: - SetConstraints

extension ScheduleListViewController {
    func setConstaints() {
        let safeArea = view.safeAreaLayoutGuide
        
        calendarHeightConstraint = NSLayoutConstraint(
            item: calendar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 300
        )
        calendar.addConstraint(calendarHeightConstraint)
        
        view.addSubview(calendar)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        view.addSubview(expandCalendarButton)
        NSLayoutConstraint.activate([
            expandCalendarButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            expandCalendarButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            expandCalendarButton.widthAnchor.constraint(equalToConstant: 100),
            expandCalendarButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: expandCalendarButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
